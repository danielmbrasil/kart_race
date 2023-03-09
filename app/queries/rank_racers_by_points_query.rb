# frozen_string_literal: true

# RankRacersByPointsQuery
class RankRacersByPointsQuery
  def self.call(tournament_id) # rubocop:disable Metrics/MethodLength
    Racer.find_by_sql([
                        'SELECT racers.*,
          sum(
          CASE
            WHEN placements.position = 1 THEN ?
            WHEN placements.position = 2 THEN ?
            WHEN placements.position = 3 THEN ?
            ELSE 0
            END
          ) as points
          FROM racers
          INNER JOIN placements
          ON placements.racer_id = racers.id
          INNER JOIN races
          ON races.id = placements.race_id
          INNER JOIN tournaments tournament
          ON tournament.id = races.tournament_id
          WHERE tournament.id = ?
          GROUP BY racers.id
          ORDER BY points DESC
          ',
                        Placement::FIRST_PLACE_POINTS,
                        Placement::SECOND_PLACE_POINTS,
                        Placement::THIRD_PLACE_POINTS,
                        tournament_id
                      ])
  end
end
