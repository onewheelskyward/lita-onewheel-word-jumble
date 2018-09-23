module Lita
  module Handlers
    class OnewheelWordJumble < Handler

      route /^words\s+([a-zA-Z]+)\s*(\d*)$/i, :words, command: true

      def words(response)
        Lita.logger.debug('Loading words...')

        # Build the dict of words
        words = {}
        File.open(File.expand_path('../../words', File.dirname(__FILE__))).each_line do |l|
          l.chomp!
          words[l.downcase] = 1
        end

        letters = response.matches[0][0]
        len = response.matches[0][1].to_i

        if len == 0
          min_len = 3
          len = letters.length
        else
          min_len = len
        end

        Lita.logger.debug "Searching for alternatives to #{letters} with a length between #{min_len} and #{len}"

        combos = []

        (min_len..len).each do |n|
          Lita.logger.debug "Checking for #{n} length words..."
          arr = []
          letters.split(//).permutation(n).to_a.map(&:join).each do |combo|
            arr.push combo if words[combo] == 1
          end
          combos.push arr.sort.uniq
        end

        combo_str = combos.join ", "

        Lita.logger.info "Returning: #{combo_str}"

        response.reply(combo_str)
      end

      Lita.register_handler(self)
    end
  end
end
