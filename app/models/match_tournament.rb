class MatchTournament < ApplicationRecord
    belongs_to :tournament 

    def semi_finals(all_matches) 
        @semi_finals = []
        all_matches.each do |match|
            @semi_finals.push(match)
        end 
        return @semi_finals
    end 

    def finals(semi_finals)
        @finals = []
        semi_finals.each do |match|
            @finals.push(match)
        end 
        return @finals 
    end 
end
