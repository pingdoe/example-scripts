#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use POSIX qw(strftime);

# EXAMPLE link replace with own url
my $url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18";
my $interval_minutes = 5;

print "Starting PingDoe heartbeat every $interval_minutes minutes...\n";

my $ua = LWP::UserAgent->new;
$ua->timeout(10);

while (1) {
    my $timestamp = strftime "%Y-%m-%d %H:%M:%S", localtime;
    my $response = $ua->get($url);

    if ($response->is_success) {
        print "[$timestamp] Ping successful: ", $response->code, "\n";
    } else {
        print "[$timestamp] Ping failed: ", $response->status_line, "\n";
    }
    
    sleep($interval_minutes * 60);
}
