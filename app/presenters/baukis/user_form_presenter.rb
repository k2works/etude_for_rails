module Baukis
  class UserFormPresenter < FormPresenter
    def password_field_block(name, label_text, options = {})
      if object.new_record?
        super(name, label_text, options)
      else
        markup(:div, class: 'input-block') do |m|
          m << decorated_label(name, label_text, options.merge(required: false))
          m << password_field(name, options.merge(disabled: true, class: 'disable'))
          m.button('変更する', type: 'button', id: 'enable-password-field')
          m.button('変更しない', type: 'button', id: 'disable-password-field',style: 'display:none')
          m << error_messages_for(name)
        end
      end
    end

    def full_name_block(name1, name2, label_text, options = {} )
      markup(:div, class: 'input-block') do |m|
        m << decorated_label(name1, label_text, options)
        m << text_field(name1, options.merge(id:'family_name'))
        m << text_field(name2, options.merge(id:'given_name'))
        m << error_messages_for(name1)
        m << error_messages_for(name2)
      end
    end

    def full_name_kana_block(name1, name2, label_text, options = {} )
      markup(:div, class: 'input-block') do |m|
        m << decorated_label(name1, label_text, options)
        m << text_field(name1, options.merge(id:'family_name_kana'))
        m << text_field(name2, options.merge(id:'given_name_kana'))
        m << error_messages_for(name1)
        m << error_messages_for(name2)
      end
    end
  end
end