#!/usr/bin/perl
use Test::More;
use Log::Any::Adapter;
use Log::Any::Adapter::Util qw(cmp_deeply);
use strict;
use warnings;

Log::Any::Adapter->set('Test');
my $log = Log::Any->get_logger();
my @params = ( "args for %s: %s", 'app', [ 'foo', { 'bar' => 5 } ] );
$log->info(@params);
$log->debugf(@params);
cmp_deeply(
    $log->msgs,
    [
        {
            message     => "args for %s: %s",
            level    => 'info',
            category => 'main'
        },
        {
            message     => q|args for app: ["foo",{bar => 5}]|,
            level    => 'debug',
            category => 'main'
        }
    ],
    'message was formatted'
);

done_testing;