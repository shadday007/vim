vim9script

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

iabbrev todo: TODO:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev fixme: FIXME:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev changed: CHANGED:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev xxx: XXX:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev bug: BUG:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev hack: HACK:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev note: NOTE:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev info: INFO:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev idea: IDEA:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev help: HELP:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev debug: DEBUG:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev error: ERROR:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):
iabbrev fatal: FATAL:<space><c-r>=strftime("%Y-%m-%d")<cr>(<c-r>=expand("$USER")<cr>):

iabbr _date <c-r>=strftime("%Y-%m-%d")<cr>
iabbr _time <c-r>=strftime("%H:%M:%S")<cr>
iabbr _now <c-r>=strftime("%A, %B %d, %H:%M")<cr>

iabbrev _shrug ¯\_(ツ)_/¯
iabbrev _sad  (︶︹︺)

iabbrev  _rg Regards,<CR>Jorge Luis Hernández

iabbrev _v9 vim9script

iabbrev _ltf logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.\|\s\)', '', ''))
