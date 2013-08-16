module Formtastic
  module Inputs
    class JustDatetimePickerInput
      include ::Formtastic::Inputs::Base


      def gt_input_name
        "q[just_datetime_picker_#{gt_name}][]"
      end

      def gt_name
        "#{method}_gte"
      end

      def lt_name
        "#{method}_lte"
      end

      alias :input_name :gt_input_name

      def lt_input_name
        "q[just_datetime_picker_#{lt_name}][]"
      end

      def to_html
        input_wrapping do
          if builder.object.respond_to?(method, true)
            as_input
          else
            as_filter
          end
        end
      end

      def as_input
        combined_value = builder.object.send(method)

        hour_value_raw = builder.object.send("#{method}_time_hour")
        if not hour_value_raw.nil?
          hour_value = hour_value_raw
        elsif not combined_value.nil?
          hour_value = combined_value.hour
        else
          hour_value = "00"
        end

        minute_value_raw = builder.object.send("#{method}_time_minute")
        if not minute_value_raw.nil?
          minute_value = minute_value_raw
        elsif not combined_value.nil?
          minute_value = combined_value.min
        else
          minute_value = "00"
        end

        hour_value = sprintf("%02d", hour_value)
        minute_value = sprintf("%02d", minute_value)

        label_html <<
            builder.text_field("#{method}_date", input_html_options.merge({:class => "just-datetime-picker-field just-datetime-picker-date datepicker", :value => builder.object.send("#{method}_date"), :maxlength => 10, :size => 10})) <<

            builder.text_field("#{method}_time_hour", input_html_options.merge({:class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-hour", :value => hour_value, :maxlength => 2, :size => 2})) <<
            ":" <<
            builder.text_field("#{method}_time_minute", input_html_options.merge({:class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :value => minute_value, :maxlength => 2, :size => 2}))
      end

      def get_minute(_for)
        name = self.send(:"#{_for}_name")
        builder.object.send("#{name}").min rescue ""
      end

      def get_hour(_for)
        name = self.send(:"#{_for}_name")
        builder.object.send("#{name}").hour rescue ""
      end

      def get_date(_for)
        name = self.send(:"#{_for}_name")
        builder.object.send("#{name}").to_date.to_s rescue ""

      end

      def input_wrapping(&block)
        template.content_tag(:div,
                             template.capture(&block),
                             wrapper_html_options
        )
      end

      def required?
        false
      end

      def wrapper_html_options
        {:class => "filter_form_field filter_date_range #{as}"}
      end

      def style_
        "width:27px;"
      end

      def as_filter
        [label_html,

         builder.text_field(gt_input_name, {:size => 12,
                                            :class => "just-datetime-picker-field just-datetime-picker-date datepicker ",
                                            :max => 10,
                                            :value => get_date("gt"), :name => input_name}),

         builder.text_field(gt_input_name, {:name => gt_input_name, :style => style_, :type => "number", :value => get_hour('gt'), :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-hour", :maxlength => 2, :size => 2}),
         "<span class='seperator'>:</span>",
         builder.text_field(gt_input_name, {:name => gt_input_name, :type => "hidden", :value => ":", :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :maxlength => 2, :size => 2}),
         builder.text_field(gt_input_name, {:name => gt_input_name, :style => style_, :type => "number", :value => get_minute('gt'), :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :maxlength => 2, :size => 2}),

         builder.text_field(lt_input_name, {:size => 12,
                                            :class => "just-datetime-picker-field just-datetime-picker-date datepicker",
                                            :max => 10,
                                            :value => get_date("lt"), :name => lt_input_name}),
         builder.text_field(lt_input_name, {:name => lt_input_name, :style => style_,:type => "number", :value => get_hour('lt'), :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-hour", :maxlength => 2, :size => 2}),
         "<span class='seperator'>:</span>",
         builder.text_field(lt_input_name, {:name => lt_input_name, :type => "hidden", :value => ":", :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :maxlength => 2, :size => 2}),
         builder.text_field(lt_input_name, {:name => lt_input_name,:style => style_, :type => "number", :value => get_minute('lt'), :id => rand(19031903), :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :maxlength => 2, :size => 2}),

        ].join("\n").html_safe
      end


    end
  end
end


