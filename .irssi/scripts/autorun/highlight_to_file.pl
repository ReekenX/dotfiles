# irssi-notify.pl
use Irssi;

$::VERSION='1.0';
%::IRSSI = (
    authors => 'Remigijus jarmalavičius',
    contact => 'remigijus@jarmalavicius.lt',
    name => 'irssi-notify',
    description => 'Displays a pop-up message if message received.',
    url => 'http://www.jarmalavicius.lt/',
    license => 'GNU General Public License',
    changed => '2012-10-22'
);

sub filewrite {
    my ($text) = @_;
    open(FILE,">>$ENV{HOME}/.irssi/logs/notify.log");
    print FILE $text . "\n";
    close (FILE);
}

sub highlight_message {
    my ($dest, $text, $stripped) = @_;
    if ($dest->{level} & MSGLEVEL_HILIGHT) {
        filewrite($dest->{target}. " " .$stripped);
    }
}

sub private_message {
    my ($server,$msg,$nick,$address) = @_;
    filewrite("[".$target."] ".$nick.": ".$msg);
}

Irssi::signal_add_last('message private', "private_message");
Irssi::signal_add_last("print text", "highlight_message");
