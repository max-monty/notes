require 'utils'
require 'open3'

class Project
  @@u = Utils.new
  @@notespath = ENV['NOTESPATH']

  def new
    if ARGV.length != 3
      puts "Error: project name must be one word\n----"
      show_help
    else
      system("touch #{@@notespath}/projects/.#{ARGV[2]}")
    end 
  end

  def list
    o = Open3.capture2("find #{@@notespath}/projects -type f")[0]
    files = o.split("\n")
    for file in files
      filename = file.split('/')[-1]
      puts "#{filename[1..-1]}"
    end
  end

  def all
    o = Open3.capture2("find #{@@notespath}/projects -type f")[0]
    files = o.split("\n")
    for file in files
      filename = file.split('/')[-1]
      project = @@u.load_project(filename)
      puts "*#{filename[1..-1]}*"
      if !project.nil?
        for i in 0..project.length-1
          puts "[#{i}] #{project[i]}"
        end
      end
      puts "----"
    end
  end

  def show
    project = @@u.load_project(".#{ARGV[1]}")
    if !project.nil?
      for i in 0..project.length-1
        puts "[#{i}] #{project[i]}"
      end
    end
  end

  def pop
    filename = ".#{ARGV[2]}"
    project = @@u.load_project(filename)
    if ARGV.length == 3
      project.pop()
      @@u.save_project(project, filename)
    else
      project.delete_at(ARGV[2].to_i)
      @@u.save_project(project, filename)
    end 
  end

  def push
    if ARGV.length == 2
      puts "must push something"
    else
      filename = ".#{ARGV[2]}"
      o = Open3.capture2("find #{@@notespath}/projects -type f -name #{filename}")[0]
      files = o.split("\n")
      if files.length() == 1
        project = @@u.load_project(filename)
        task =  ARGV[2..-1].join(' ')
        if project.nil?
          project = [task]
        else
          project.push(ARGV[3..-1].join(' '))
        end
        @@u.save_project(project, filename)
      elsif files.length() < 1
        puts "project not found"
      else files.length() > 1
        count = 0
        for file in files
          puts "[#{count}]  #{file}\n"
          count = count + 1
        end
        print "Choose an index: "
        index = STDIN.gets.to_i
      end
    end
  end

  def remove
    if ARGV.length != 3
      @@u.show_help
    end 
    system("rm $NOTESPATH/projects/.#{ARGV[2]}")
  end
end
