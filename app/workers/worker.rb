class HardWorker
	include Sidekiq::Worker
  def perform(complexity)
  case complexity
  when "hard"
  	sleep 10
  	puts "hard"
  when "easy"
  	sleep 1
  	puts "easy"
  end
   
  end
end