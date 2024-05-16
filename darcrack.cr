require "digest"
require "colorize"
require "option_parser"

LOGO = "
================================================================
██████╗  █████╗ ██████╗  ██████╗██████╗  █████╗  ██████╗██╗  ██╗
██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝
██║  ██║███████║██████╔╝██║     ██████╔╝███████║██║     █████╔╝ 
██║  ██║██╔══██║██╔══██╗██║     ██╔══██╗██╔══██║██║     ██╔═██╗ 
██████╔╝██║  ██║██║  ██║╚██████╗██║  ██║██║  ██║╚██████╗██║  ██╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ 
================================================================
"

def print_logo()
	puts LOGO.colorize(:red)
end

def usage()
	puts "[!] Something went wrong. Check the correctness of the entered data and try again".colorize(:red)
	puts "[!] Usage: ./darcrack <hash> <path_to_wordlist>".colorize(:red)
	exit(1)
end

def identify_hash()
	case ARGV[0].size
	when 32
		return 1 # MD5
	when 40
		return 2 # SHA1
	when 64
		return 3 # SHA256
	when 128
		return 4 # SHA512
	else
		puts "[!] ERROR: Hash type unindentified".colorize(:red)
		exit(1)
	end
end

def main()
	if ARGV.size < 2 || !File.exists?(ARGV[1])
		usage
	end
	wordlist = File.open(ARGV[1])
	print_logo
	puts "[*] Identifying hash type...".colorize(:blue)
	case identify_hash
	when 1
		puts "[#] Hash type is MD5. Starting bruteforce attack...".colorize(:blue)
		wordlist.each_line do |line|
			puts "[*] Trying #{line}...".colorize(:blue)
			if Digest::MD5.hexdigest(line) == ARGV[0]
				puts "[$] Plaintext found: #{line}!".colorize(:green)
				exit(0)
			end
		end
	when 2
		puts "[#] Hash type is SHA128. Starting bruteforce attack...".colorize(:blue)
		wordlist.each_line do |line|
			puts "[*] Trying #{line}...".colorize(:blue)
			if Digest::SHA1.hexdigest(line) == ARGV[0]
				puts "[$] Plaintext found: #{line}!".colorize(:green)
				exit(0)
			end
		end
	when 3
		puts "[#] Hash type is SHA256. Starting bruteforce attack...".colorize(:blue)
		wordlist.each_line do |line|
			puts "[*] Trying #{line}...".colorize(:blue)
			if Digest::SHA256.hexdigest(line) == ARGV[0]
				puts "[$] Plaintext found: #{line}!".colorize(:green)
				exit(0)
			end
		end
	when 4
		puts "[#] Hash type is SHA512. Starting bruteforce attack...".colorize(:blue)
		wordlist.each_line do |line|
			puts "[*] Trying #{line}...".colorize(:blue)
			if Digest::SHA512.hexdigest(line) == ARGV[0]
				puts "[$] Plaintext found: #{line}!".colorize(:green)
				exit(0)
			end
		end
	end
end

main