
require_relative "users.rb"
require_relative "question_follows.rb"
require_relative "replies.rb"

class Question
    attr_accessor :title,:body, :author_id
    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id) 
			SELECT
				*
			FROM
				questions
			WHERE
				id = ?
		SQL
		questions.map{|question| Question.new(question)}
    end

    def initialize(options)
		@id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end


end