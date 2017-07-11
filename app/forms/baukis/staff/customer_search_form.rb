class Baukis::Staff::CustomerSearchForm
  include ActiveModel::Model
  include Baukis::StringNormalizer

  attr_accessor :family_name_kana, :given_name_kana, :birth_year, :birth_month, :birth_mday, :address_type, :prefecture, :city, :phone_number, :gender, :postal_code, :last_four_digits_of_phone_number

  def initialize(params={})
    assign_attributes(search_params(params)) unless params.empty?
  end

  def search
    normalize_values

    rel = Baukis::Customer
    if family_name_kana.present?
      rel = rel.where(family_name_kana: family_name_kana)
    end
    if given_name_kana.present?
      rel = rel.where(given_name_kana: given_name_kana)
    end
    rel = rel.where(birth_year: birth_year) if birth_year.present?
    rel = rel.where(birth_month: birth_month) if birth_month.present?
    rel = rel.where(birth_mday: birth_mday) if birth_mday.present?

    if last_four_digits_of_phone_number.present?
      rel = rel.joins(:phones).where('baukis_phones.last_four_digits' => last_four_digits_of_phone_number)
    end

    rel.order(:family_name_kana, :given_name_kana)

    if prefecture.present? || city.present?
      case address_type
        when 'home'
          rel = rel.joins(:home_address)
        when 'work'
          rel = rel.joins(:work_address)
        when ''
          rel = rel.joins(:addresses)
        else
          raise
      end
      if prefecture.present?
        rel = rel.where('baukis_addresses.prefecture' => prefecture)
      end
      rel = rel.where('baukis_addresses.city' => city) if city.present?
    end

    if postal_code.present?
      case address_type
        when 'home'
          rel = rel.joins(:home_address)
        when 'work'
          rel = rel.joins(:work_address)
        when ''
          rel = rel.joins(:addresses)
        else
          raise
      end
      rel = rel.where('baukis_addresses.postal_code' => postal_code)
    end

    if phone_number.present?
      rel = rel.joins(:phones).where('baukis_phones.number_for_index' => phone_number)
    end

    if gender.present?
      case gender
        when '男性'
          rel = rel.where(gender: 'male')
        when '女性'
          rel = rel.where(gender: 'female')
        else
          raise
      end
    end

    rel.order(:family_name_kana, :given_name_kana)
  end

  private
  def search_params(params)
    params.require(:search).permit(
        :family_name_kana,
        :given_name_kana,
        :birth_year,
        :birth_month,
        :birth_mday,
        :address_type,
        :prefecture,
        :city,
        :phone_number,
        :gender,
        :postal_code,
        :last_four_digits_of_phone_number
    )
  end

  def normalize_values
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
    self.city = normalize_as_name(city)
    self.phone_number = normalize_as_phone_number(phone_number).try(:gsub, /\D/, '')
    self.postal_code = normalize_as_postal_code(postal_code)
  end
end
