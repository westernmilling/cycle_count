module MenuHelper
  def menu
    content_tag('ul', class: 'nav navbar-nav navbar-right') do
      if user_signed_in?
        [
          root_menu,
          menu_item(t('locations.title'), locations_path),
          admin_menu,
          user_menu
        ].join.html_safe
      else
        menu_item(t('devise.sign_in'), new_user_session_path)
      end
    end
  end

  def root_menu
    items = []
    items.join.html_safe
  end

  def menu_item(name, path, options = nil)
    content_tag('li') do
      link_to name, path, options
    end
  end

  def admin_menu
    menu_dropdown(t('admin.title')) do
      concat menu_item(t('admin.users.title'),
                       admin_users_path)
    end
  end

  def menu_dropdown(name, classes = [])
    dropdown_class = (classes << 'dropdown-toggle').join(' ')
    content_tag('li', class: 'dropdown') do
      concat(
        link_to('#',
                class: dropdown_class,
                'data-toggle': 'dropdown') do
          concat name
          concat '&nbsp;'.html_safe
        end
      )
      concat(
        content_tag('ul', class: 'dropdown-menu') do
          yield
        end
      )
    end
  end

  def user_menu
    user_fragment = "#{current_user.name}#{gravatar}".html_safe

    menu_dropdown(user_fragment, ['user-dropdown']) do
      concat menu_item(t('devise.sign_out'),
                       destroy_user_session_path, method: :delete)
    end
  end

  def gravatar
    gravatar_image_tag(current_user.email,
                       alt: current_user.name,
                       class: 'img-circle')
  end
end
