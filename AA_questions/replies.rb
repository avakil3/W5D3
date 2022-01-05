class Replies

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id) 
			SELECT
				*
			FROM
                replies
			WHERE
				author_id = ?
		SQL
		replies.map{|reply| Replies.new(reply)} 
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id) 
			SELECT
				*
			FROM
                replies
			WHERE
				question_id = ?
		SQL
		replies.map{|reply| Replies.new(reply)} 
    end
    
  
  
    def initialize(options)
		@id = options['id']
        @question_id = options['question_id'],
        @parent_reply_id = options['parent_reply_id'],
        @author_id = options['author_id'],
        @body = options['body']
    end

end