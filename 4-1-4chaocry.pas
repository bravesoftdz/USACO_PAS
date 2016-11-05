{
ID:kjinxin1
PROG:cryptcow
LANG:PASCAL
}
const
	goal:string='Begin the Escape execution at the Break of Dawn';
	prime:longint=99991;
	letter:set of char=['C','O','W'];
var
	ch:char;
	i,j,ls,quit:longint;
	st:string;
	stan,che,fp:array[' '..'z']of longint;
	h1:array[0..99990]of boolean;
	h2:array[0..99990]of boolean;

procedure shut;
begin
	writeln('0 0');
	close(output);
	halt;
end;

function stringhash(str:string):longint;
var
	i,sum:dword;
begin
	sum:=0;
	for i:=1 to length(str) do
		sum:=(sum*65599+ord(str[i]))and $ffffffff;
	exit(sum mod prime)
end;

function exchange(str:string; a,b,c:longint):string;
var
	s1,s2,tmp:string;
begin
	tmp:=str;
	s1:=copy(tmp,b+1,c-b-1); delete(tmp,b,c-b+1);
	s2:=copy(tmp,a+1,b-a-1); insert(s2,tmp,b);
	delete(tmp,a,b-a); insert(s1,tmp,a); exit(tmp);
end;

procedure init;
begin
	readln(st); ls:=length(st); close(input);
	if (ls-47)mod 3<>0 then shut;
	quit:=(ls-47) div 3;
	for i:=1 to 47 do inc(stan[goal[i]]);
	for i:=1 to ls do inc(che[st[i]]);
	if (che['C']<>che['O'])or(che['O']<>che['W']) then shut;
          che['C']:=0; che['O']:=0; che['W']:=0;
	for ch:=' ' to 'z' do if che[ch]<>stan[ch] then shut;
	if ls=47 then begin writeln('1 0'); close(output); halt; end;       	for i:=1 to 47 do
		for j:=1 to 47 do
			h1[stringhash(copy(goal,i,j-i+1))]:=true;
end;

procedure search(x:longint; s:string);
var
	i,j,k,l,r,len:longint;
	tmp:string;
	cal:array[1..3]of longint;
	pos:array[1..3,1..9]of longint;
	postmp:array[1..27]of longint;
begin
	if (x>quit)and(s=goal) then begin writeln(1,' ',quit); close(output); halt; end;
	len:=length(s);
	h2[stringhash(s)]:=true;
	l:=1;
	while not(s[l] in letter) do inc(l);
	if (s[l]<>'C')or not(h1[stringhash(copy(s,1,l-1))]) then exit;
	r:=len;
	while not(s[r] in letter) do dec(r);
	if (s[r]<>'W')or not(h1[stringhash(copy(s,r+1,len-r))]) then exit;
        fillchar(cal,sizeof(cal),0); fillchar(pos,sizeof(pos),0); fillchar(postmp,sizeof(postmp),0);
	j:=0;
	for i:=1 to len do
	if s[i] in letter then
	begin
		inc(cal[fp[s[i]]]);
		pos[fp[s[i]],cal[fp[s[i]]]]:=i;
		inc(j); postmp[j]:=i;
	end;
	for i:=1 to j-1 do
	if not(h1[stringhash(copy(s,postmp[i]+1,postmp[i+1]-postmp[i]-1))]) then exit;//大cut3：如果其中任意一段没出现过，剪枝
	for i:=1 to cal[1] do
		for j:=1 to cal[1] do
			for k:=cal[1] downto 1 do
			if (pos[1,j]<pos[2,i])and(pos[2,i]<pos[3,k]) then
			begin
				tmp:=exchange(s,pos[1,j],pos[2,i],pos[3,k]);
				if h2[stringhash(tmp)] then break;
				search(x+1,tmp);
			end;
end;

procedure main;
begin
	fp['C']:=1; fp['O']:=2; fp['W']:=3;
	search(1,st);
	shut;
end;

begin
	assign(input,'cryptcow.in'); reset(input);
	assign(output,'cryptcow.out'); rewrite(output);
	init;
	main;
end.