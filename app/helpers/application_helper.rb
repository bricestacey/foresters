module ApplicationHelper
  MONTH_OPTIONS_FOR_SELECT = [['January', 1],
                              ['February', 2],
                              ['March', 3],
                              ['April', 4],
                              ['May', 5],
                              ['June', 6],
                              ['July', 7],
                              ['August', 8],
                              ['September', 9],
                              ['October', 10],
                              ['November', 11],
                              ['December', 12]]

  def date_to_text_selectors(field, f, obj)
    %{
    <div class="inline-fields">
      <div class="field">
        #{f.label field+"_month", 'Month'}
        #{f.select(field+"_month", options_for_select(MONTH_OPTIONS_FOR_SELECT, f.object.send(field+"_month")), {include_blank: true}, {class: 'field-date-month'})}
      </div>
      <div class="field">
        #{f.label field+"_date", 'Day'}
        #{f.text_field "#{field}_date", class: 'field-date-day'}
      </div>
      <div class="field">
        #{f.label field + "_year", 'Year'}
        #{f.text_field field + "_year", {class: 'field-date-year'}}
      </div>
    </div>
    }.html_safe
  end
end
