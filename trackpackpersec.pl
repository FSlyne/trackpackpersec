#!/usr/bin/perl

use threads;
use threads::shared;

# use Time::HiRes qw(time alarm sleep);

$alarmint = 1;

my $lc=0; share $lc;
my %stat; share %stat;
$|=1;

my @int = qw(p5p1 p5p2 p6p1);

$SIG{ALRM} = sub {
        my $base = $stat{@int[0]};
        foreach my $key (@int) {
                printf "%s ", $stat{$key};
        }
        foreach my $key (@int) {
                printf "%s ",$stat{$key}-$base;
                $stat{$key}=0;
        }
        print "\n";
        alarm $alarmint;
};
alarm $alarmint;

foreach my $int (@int) {
        threads->create(\&track_int,$int);
}

while(1>0) {
        sleep 1;
}

track_int();

exit;

sub track_int {
my $int = $_[0];
my $int = $_[0];
my $cmd = "sudo ngrep -l -qt -d $int port 9996 | grep 9996 ";
print "track_int: starting $cmd\n";
open(CMD,"$cmd|") || die $!;
while(<CMD>){
        $stat{$int}++;
#       printf "%d %s",$lc,$_;
}
}
