module Lita
  module Handlers
    class OnewheelWordJumble < Handler

      route /^words\s+([a-zA-Z]+)\s*(\d*)$/i, :words, command: true

      def words(response)
        Lita.logger.debug('Loading words...')

        words = {}
        File.open('lib/words').each_line do |l|
          l.chomp!
          words[l.downcase] = 1
        end

        letters = response.matches[0][0]
        len = response.matches[0][1].to_i

        if len == 0
          len = letters.length
        end

        puts "Searching for alternatives to #{letters} with a length of #{len}"

        combos = []

        letters.split(//).permutation(len).to_a.map(&:join).each do |combo|
          combos.push combo  if words[combo] == 1
        end

        combo_str = combos.sort.uniq.join ", "

        Lita.logger.info("Returning: #{combo_str}")

        response.reply(combo_str)
      end

      Lita.register_handler(self)
    end
  end
end
