module EntriesHelper

  def today
    Date.today.to_formatted_s(:date_nice)
  end
end
