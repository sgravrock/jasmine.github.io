module Jekyll
    class NewVersionLink < Liquid::Tag
        def render(context)
            page = context.registers[:page]
            site = context.registers[:site]

            case page['collection']
            when 'api'
                for_api_reference(page, '/api/', 'Jasmine',
                    site.collections['api'])
            when 'npm-api'
                for_api_reference(page, '/api/npm/', 'Jasmine',
                    site.collections['npm-api'])
            when 'browser-runner-api'
                for_api_reference(page, '/api/browser-runner/',
                    'jasmine-browser-runner',
                    site.collections['browser-runner-api'])
            when 'archives'
                for_archived_doc(page, site)
            end
        end

        def for_api_reference(page, prefix, name, collection)
            this_version = page['url'].sub(prefix, '').split('/').first
            latest = current_version(collection)
            if page.url == '/api/npm/5.0.0-alpha.1/Jasmine' then
                require 'pry'; binding.pry
            end
            if this_version == 'edge' || this_version == latest
                return
            end

            page_name = page['url'].split('/').last

            if is_prerelease(this_version)
                final = this_version.sub(/-.*$/, '')
                msg = <<~END
                    This page describes a pre-release version of #{name}
                    (#{this_version}). There may be additional changes,
                    including breaking changes, before the final
                    #{final} release.<br>
                    The current stable version of #{name} is
                    <a href="#{prefix}#{latest}/#{page_name}">#{latest}</a>.
                END
            else
                msg = <<~END
                    This page is for an older version of #{name}
                    (#{this_version}).<br/>
                    The current stable version of #{name} is:
                    <a href="#{prefix}#{latest}/#{page_name}">#{latest}</a>.
                    You can also look at the docs for the next release: <a href="#{prefix}edge/#{page_name}">Edge</a>
                END
            end

            wrap(msg)
        end

        def for_archived_doc(page, site)
            this_version = page['url'].sub(/^\/archives\//, '').split('/').first
            latest = current_version(site.collections['api'])
            page_name = page['url'].split('/').last
            <<~END
                <div class="warning">
                    This page is for an older version of Jasmine
                    (#{this_version})<br/>
                    The current stable version of Jasmine is:
                    <a href="/api/#{latest}/#{page_name}">#{latest}</a> -
                    You can also look at the docs for the next release: <a href="/api/edge/#{page_name}">Edge</a>
                </div>
            END
        end


        def wrap(msg)
            <<~END
                <div class="main-content">
                    <div class="warning">#{msg}</div>
                </div>
            END
        end

        def current_version(collection)
            latest = collection.entries
                .filter_map { |entry|
                    elems = entry.split('/')
                    if elems.length > 1 && !is_prerelease(elems[0]) then
                        begin
                            [elems[0], Gem::Version.new(elems[0])]
                        rescue ArgumentError
                            # E.g. "edge". Ignore.
                        end
                    end
                }
                .max_by { |s, v| v }
            latest[0]
        end

        def is_prerelease(v)
            v.include?('-')
        end
    end
end

Liquid::Template.register_tag('new_version_link', Jekyll::NewVersionLink)