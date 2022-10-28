# frozen_string_literal: true

# Credit to https://github.com/rossmeissl/indefinite_article
class Inflections
  A_REQUIRING_PATTERNS = /^(([bcdgjkpqtuvwyz])$|e[uw]|uk|ubi|ubo|oaxaca|ufo|ur[aeiou]|use|ut([^t])|unani|uni(l[^l]|[a-ko-z]))/i
  AN_REQUIRING_PATTERNS = /^([aefhilmnorsx]$|hono|honest|hour|heir|[aeiou]|8|11)/i

  def self.indefinite_article(text)
    first_word = text.split.first

    if first_word[AN_REQUIRING_PATTERNS] && !first_word[A_REQUIRING_PATTERNS]
      "an"
    else
      "a"
    end
  end
end
