
module FeetExpander

  class << self

    def expand(s)

      s
        .gsub(
          %r{
            (\d+\/)?
            (\d[.,]\d+|[.,]\d+|\d+)[- ]*
            (foot|feet|ft\.?)
          }xi) { expand_feet($1, $2, $3) }
    end

    protected

    def expand_feet(r0, r1, unit)

      [ r0 ? do_expand_feet(r0) : nil, do_expand_feet(r1) ]
        .compact.join(' / ')
    end

    def rtos(range)

      case r = ("%.1f" % range)
      when /\.[1-9]/ then r.to_f.to_s
      when /\.0*/ then r.to_i.to_s
      else r
      end
    end

    def do_expand_feet(range)

      ft = range.to_f; return '0ft' if ft == 0.0
      m = ft * 0.3
      sq = ft * 0.2

      st = to_sticks(ft); st = nil if st.match?(/\A\+\d\z/)

      [ "#{rtos(ft)}ft", "#{rtos(m)}m", "#{rtos(sq)}sq", st ]
        .compact
        .join('_')
    end

    def to_sticks(ft, reduce=true)

      s =
        if ft == 150.0
          'FFFt' # ;-)
        elsif ft < 20
          "+#{rtos(ft / 5.0)}"
        elsif ft < 30
          "t-#{rtos((30 - ft) / 5.0)}"
        elsif ft % 40.0 == 0
          'F' * (ft / 40.0).to_i
        elsif ft % 30.0 == 0
          't' * (ft / 30.0).to_i
        elsif ft < 40
          "F-#{rtos((40 - ft) / 5.0)}"
        else
          'F' + to_sticks(ft - 40, false)
        end

      return s unless reduce

      s
        .gsub(/F+/) { |fs| fs.length > 3 ? "#{fs.length}F" : fs }
        .gsub(/t+/) { |ts| ts.length > 3 ? "#{ts.length}t" : ts }
    end
  end
end

