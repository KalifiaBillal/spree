module Spree
  module MailHelper
    include BaseHelper

    def variant_image_url(variant)
      image = default_image_for_product_or_variant(variant)
      image ? main_app.url_for(image.url(:small)) : 'noimage/small.png'
    end

    def name_for(order)
      order.name || Spree.t('customer')
    end

    def logo_store
      @order&.store || current_store
    end

    def logo_path
      if logo_store.present? && logo_store.logo.attached? && logo_store.logo.variable?
        main_app.url_for(logo_store.logo.variant(resize: '244x104>'))
      elsif logo_store.present? && logo_store.logo.attached? && logo_store.logo.image?
        main_app.url_for(logo_store.logo)
      else
        Spree::Config.mailer_logo || Spree::Config.logo
      end
    end
  end
end
