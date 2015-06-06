require 'mechanize'

class Retriever

  DOG_DATA_URL = 'http://infoportal.alleghenycounty.us/dogdata/default.aspx'

  def get_export_button page
    page.forms.first.buttons.find { |b| b.name == 'btnSearchtoFormats' }
  end

  def get_year_drop_down page
    page.forms.first.fields.find{|f| f.name == 'DropDownList1' }
  end

  def initialize
    @agent = Mechanize.new
  end

  def get_first_page
    @agent.get(DOG_DATA_URL)
  end

  def set_year page, year
    dd = get_year_drop_down page
    dd.value = year.to_s
  end

  def year page
    get_year_drop_down(page).value
  end

  def get_csv_data page
    year = get_year_drop_down(page).value
    puts "getting #{year}"
    @agent.submit(page.forms.first, get_export_button(page))
  end

end
