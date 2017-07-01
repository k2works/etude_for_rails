class PerfectRails::Music
  extend ActiveModel::Callbacks

  attr_accessor :title, :created_at, :listened_at

  define_model_callbacks :create, :play

  define_model_callbacks :create, :play

  before_play :display_title
  after_create ->(music) { music.created_at = Time.current }

  def self.create(title: nil)
    music = new
    music.title = title
    music.create
  end

  def create
    run_callbacks :create do
      puts "created"
      self
    end
  end

  def play
    run_callbacks :play do
      puts "played"
    end
  end

  private

  def display_title
    puts title
  end
end