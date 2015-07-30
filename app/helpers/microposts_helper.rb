module MicropostsHelper
include ActionView::Helpers::OutputSafetyHelper
  REPLY_TO_REGEX = /@(\w[a-zA-Z0-9]*)\s/i

  def wrap(content)
    ActionController::Base.helpers.sanitize(raw(content.split.map{ |s| wrap_long_string(s)}.join(' ')))
  end

  def highlight_reply_user(content, user)
    if user
      highlight(content, REPLY_TO_REGEX, :highlighter => "<a href=users/#{user.id}>@#{user.account_name}</a>")
    else
      content
    end
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
