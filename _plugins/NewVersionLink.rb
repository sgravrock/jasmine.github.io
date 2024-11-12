module Jekyll
    class NewVersionLink < Liquid::Tag
#           def initialize(tag_name, text, tokens)
#           puts "init"
# #          super
# #           @text = text
#         end

        def render(context)
            page = context.registers[:page]
            site = context.registers[:site]

            if page['collection'] == 'api' then
                for_api_reference(page, site)
            elsif page['collection'] == 'archives' then
                for_archived_doc(page, site)
            else
                "something else"
            end
        end

        def for_api_reference(page, site)
            this_version = page['url'].sub(/^\/api\//, '').split('/').first
            latest = current_version(site.collections['api'])
            if this_version == 'edge' || this_version == latest
                return
            end

            page_name = page['url'].split('/').last
            is_prerelease = this_version.include?('-')

            if is_prerelease
                final = this_version.sub(/-.*$/, '')
                msg = <<~END
                    This page describes a pre-release version of Jasmine
                    (#{this_version}). There may be additional changes,
                    including breaking changes, before the final
                    #{final} release.<br>
                    The current stable version of Jasmine is
                    <a href="/api/#{latest}/#{page_name}">#{latest}</a>.
                END
            else
                msg = <<~END
                    This page is for an older version of Jasmine
                    (#{this_version}).<br/>
                    The current stable version of Jasmine is:
                    <a href="/api/#{latest}/#{page_name}">#{latest}</a>.
                    You can also look at the docs for the next release: <a href="/api/edge/{{ pageName }}">Edge</a>
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
                    You can also look at the docs for the next release: <a href="/api/edge/{{ pageName }}">Edge</a>
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
            collection.entries
                .filter_map { |entry|
                    elems = entry.split('/')
                    if elems.length > 1 then
                        begin
                            Gem::Version.new(elems[0])
                        rescue ArgumentError
                            # E.g. "edge". Ignore.
                        end
                    end
                }
                .max.to_s
        end
    end
end

Liquid::Template.register_tag('new_version_link', Jekyll::NewVersionLink)