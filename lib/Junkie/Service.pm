package Junkie::Service;
use Moose::Role;

our $VERSION = '0.01';

with 'MooseX::Param',
     'Junkie::Traversable';

has 'name' => (
    is       => 'rw', 
    isa      => 'Str', 
    required => 1
);

has 'is_locked' => (
    is      => 'rw',
    isa     => 'Bool',
    default => sub { 0 }
);

has 'lifecycle' => (
    is      => 'rw', 
    isa     => 'Str', 
    trigger => sub {
        my ($self, $lifecycle) = @_;
        if ($self->does('Junkie::LifeCycle')) {
            bless $self => ($self->meta->superclasses)[0];
            return if $lifecycle eq 'Null';
        }
        ("Junkie::LifeCycle::${lifecycle}")->meta->apply($self);        
    }
);

requires 'get';

sub lock   { (shift)->is_locked(1) }
sub unlock { (shift)->is_locked(0) }

1;

__END__

=pod

=head1 NAME

Junkie::Service - A fix for what ails you

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut