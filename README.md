# Samich Application #

| Parameter | Value                |
| :---------- | :----------------- |
| File        | README.md          |
| Author      | Paul Calnon        |
| Version     | 0.1                |
| Created     | June 2, 2014       |
| Modified    | June 2, 2014       |
| Copyright   | 2014, KU, ITTC     |



## Description ##

The Samich application is intended to server as a flexible and easy to use web GUI to Torque / Maui for new cluster users.

The Samich application was developed using Ruby on Rails because it is just that simple a problem.


-------------------------------------------------------------------


## Notes: ##

### Running system commands (e.g., shell commands) from Ruby: ###

#### 1. Use Exec ####

exec 'echo "hello $HOSTNAME"'

Using exec replaces the irb process is with the echo command which then exits. Because the Ruby effectively ends this method has only limited use. The major drawback is that you have no knowledge of the success or failure of the command from your Ruby script.


-------------------------------------------------------------------

#### 2. Use System ####

system 'echo "hello $HOSTNAME"'

Using system sets the global variable $? to the exit status of the process. Notice that we have the exit status of the false command (which always exits with a non-zero code). Checking the exit code gives us the opportunity to raise an exception or retry our command.
Note for Newbies: Unix commands typically exit with a status of 0 on success and non-zero otherwise.

System is great if all we want to know is “Was my command successful or not?” However, often times we want to capture the output of the command and then use that value in our program.


-------------------------------------------------------------------

#### 3. Use Backticks or %x ####

today = `date`
today = %x(date)

Using backticks runs the command in a subshell and returns the standard output from that command.

This is probably the most commonly used and widely known method to run commands in a subshell. As you can see, this is very useful in that it returns the output of the command and then we can use it like any other string.

Notice that $? is not simply an integer of the return status but actually a Process::Status object. We have not only the exit status but also the process id. Process::Status#to_i gives us the exit status as an integer (and #to_s gives us the exit status as a string).

One consequence of using backticks is that we only get the standard output (stdout) of this command but we do not get the standard error (stderr). In this example we run a Perl script which outputs a string to stderr.


-------------------------------------------------------------------

#### 4. Use Open3#popen3 ####

stdin, stdout, stderr = Open3.popen3('dc') 
stdin.puts(5)
stdin.puts(10)
stdin.puts("+")
stdin.puts("p")
stdout.gets
  => "15\n" 

The Ruby standard library includes the class Open3. It’s easy to use and returns stdin, stdout and stderr. In this example, lets use the interactive command dc. dc is reverse-polish calculator that reads from stdin. In this example we will push two numbers and an operator onto the stack. Then we use p to print out the result of the operator operating on the two numbers. Below we push on 5, 10 and + and get a response of 15\n to stdout.


-------------------------------------------------------------------

#### 5. Use Open4#popen4 ####

require "open4" 
pid, stdin, stdout, stderr = Open4::popen4 "false" 
$?
pid
=> 26327
ignored, status = Process::waitpid2 pid
=> [26327, #<Process::Status: pid=26327,exited(1)>]
status.to_i
=> 256

Open4#popen4 is a Ruby Gem put together by Ara Howard. It operates similarly to open3 except that we can get the exit status from the program. popen4 returns a process id for the subshell and we can get the exit status from that waiting on that process. (You will need to do a gem instal open4 to use this.)

A nice feature is that you can call popen4 as a block and it will automatically wait for the return status.

require "open4" 
status = Open4::popen4("false") do |pid, stdin, stdout, stderr| puts "PID #{pid}" 
end
PID 26598
=> #<Process::Status: pid=26598,exited(1)>
puts status
256



Additional Sample:

    status = POpen4::popen4( cmd_ ) do |stdout, stderr, stdin|  
        stdout.each do |line|  
          puts line  
          end  
     end  
    puts status.exitstatus  

POpen4 provides a single API across platforms for executing a command in a child process with handles on stdout, stderr, stdin streams as well as access to the process ID and exit status. It does very little other than to provide an easy way to use either Ara Howard’s Open4 library or the win32-popen3 library by Park Heesob and Daniel Berger depending on your platform and without having to code around the slight differences in their APIs.

With POpen4, you can very easily get the exit status. If the program/command is running successfully, it will return 0, if there is any exception happening than it will return exit status 1. And if your program/command has control to either exit 0 or exit 1. All these exit status will be captured. However, both IO.popen and POpen4 can’t capture the output in realtime. The whole output stream is buffered and is only available when the command has finished running. Unless the running command/program flush the output every time it output something. But at most of time, we don’t have any control over the running command/program. 


-------------------------------------------------------------------

#### 6. Use Psuedo Terminal ####

    require "pty"  
        begin  
          PTY.spawn( cmd_ ) do |r, w, pid|  
            begin  
              r.each { |line| print line;}  
           rescue Errno::EIO  
           end  
         end  
       rescue PTY::ChildExited => e  
          puts "The child process exited!"  
       end  


Pty is pseudo terminal and is only available under \*.nix System. If you are using it under windows, you should see the error : No such file to load pty. So far, i didn’t find any alternative for pty in windows. Pty acts as if someone is running the command in a terminal, so the output is immediately flushed out. Bad thing with pty is that it behaves quite strange, sometimes, it will just jumps to the ChildExited exception even when you look at the output of the running command, everything has finished running. E.g. recently I have a rake task that zip a bunch of files from a certain folder. The zip file is successfully zipped, but it will go to the exception and print “The child process exited”. I still haven’t figure out what’s wrong with this and how do I capture the exit status correctly. If in the running command/program, i do exit 1. The pty won’t capture this exit status. Instead, it will always has the exit status of 0.




