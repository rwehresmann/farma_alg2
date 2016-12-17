module AnswerHelper
  # The update methods are a trick to solve a bad formulation of the answer
  # model. After a recall of the farma-alg-production data, they can be deleted.
  
  def update_question(answer)
    answer.update_attributes(question: Question.find(answer.question_id))
  end

  def update_team(answer)
    answer.update_attributes(team: Team.find(answer.team_id))
  end

  def update_lo(answer)
    answer.update_attributes(lo: Lo.find(answer.lo_id))
  end
end
