# see the c# version for a fuller description of what's going on
# comments here are just to document tricks specific to the ruby version

require "curses"
# load the Curses class into a local and global var (it's cheaper to use both)
include $a = a = Curses

def w( i )
  i < 5 ? i : 5 - i + 4
end

$m="#### #  ###    ##    #   "

for j in 0..9
  for i in 0..9
    # use input record seperator $/ instead of "\n"
    # see http://ruby.runpaint.org/globals
    a.addstr $m[ w(j) * 5 + w(i) ].chr + ( i > 8 ? $/ : "" )
  end
end

$x = $y = 2

# draw tile
def d( t = "@" )
  $a.setpos $y, $x
  $a.addstr t
end

# move player
def m( x, y )
  # 32 is the character code for a whitespace
  $x, $y = x,y if $m[ w(y) * 5 + w(x) ] == 32
end

s = a.init_screen
a.noecho
a.curs_set 0
# use 1 instead of TRUE
s.keypad 1
d

until ( c = s.getch ) == ?q
  # use character codes instead of KEY_UP, KEY_DOWN etc.
  k = { 259 => [$x, $y - 1],
        258 => [$x, $y + 1],
        260 => [$x - 1, $y],
        261 => [$x + 1, $y] }
  d " "
  m *k[c] if k[c]
  d
end