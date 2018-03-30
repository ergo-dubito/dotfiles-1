# This sources every file beginning with a dot in the main
# dotfiles repo

for file in ~/dotfiles/dots/*; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
