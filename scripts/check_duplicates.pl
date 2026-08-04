#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

my @files = glob('research/*.md');
my %seen;
my @duplicates;

for my $file (@files) {
    open my $fh, '<:encoding(UTF-8)', $file or die "cannot open $file: $!";
    local $/ = "\n\n";
    my $index = 0;
    while (my $paragraph = <$fh>) {
        $index++;
        $paragraph =~ s/^\s+|\s+$//g;
        next if $paragraph =~ /^(?:#|>|```|[-*] \[A\d{3}\])/;
        next if $paragraph =~ /^\|/;
        my $normalized = lc $paragraph;
        $normalized =~ s/\s+/ /g;
        next if length($normalized) < 180;
        if (exists $seen{$normalized}) {
            push @duplicates, "$file paragraph $index duplicates $seen{$normalized}";
        } else {
            $seen{$normalized} = "$file paragraph $index";
        }
    }
    close $fh;
}

print "long paragraphs checked: ", scalar(keys %seen), "\n";
print "duplicate long paragraphs: ", scalar(@duplicates), "\n";
if (@duplicates) {
    print "$_\n" for @duplicates;
    exit 1;
}
print "PASS: no duplicate long paragraphs\n";
