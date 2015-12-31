module ApplicationHelper
  # A simple way to show the error messages for an ActiveRecord model.
  # @params object [Object] the object inheriting from ActiveRecord::Base.
  # @return [String] the error messages in HTML.
  def error_messages(object)
    return nil if object.errors.blank?

    content_tag 'div',
                class: 'alert alert-danger',
                role: 'alert' do
      concat content_tag('strong', 'There were errors with your submission.')
      concat(
        content_tag('ul', class: 'errors') do
          object
            .errors
            .full_messages
            .each { |message| concat content_tag('li', message) }
        end
      )
    end
  end
end
