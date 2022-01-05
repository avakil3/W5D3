require_relative "questions.rb"
require_relative "users.rb"
require_relative "replies.rb"

class QuestionFollows

    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id) 
			SELECT
				*
			FROM
                 question_follows
			WHERE
				id = ?
		SQL
		QuestionFollows.new(question_follow.first) 
    end

    attr_accessor :user_id, :question_id
    def initialize(options)
		@id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

end