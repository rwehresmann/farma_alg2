class Tip
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :number_of_tries, type: Integer, default: 1

  # Q: belongs to question, but question have not specificated a relationship with tip model
  belongs_to :question

  validates_presence_of :content, :number_of_tries
  validates :number_of_tries, numericality: { only_integer: true,
                                              greater_than: 0, less_than: 15 }
  # question_id scope means that it must be unique in each question, but can be
  # be repeated between questions.
  validates :number_of_tries, uniqueness: { scope: :question_id,
            message: "Já existe uma dica cadastrada com esse número de tentativas." }

  default_scope -> { desc(:number_of_tries) }
end
