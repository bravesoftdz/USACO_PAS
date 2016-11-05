{
ID:kjinxin1
PROG:cryptcow
LANG:PASCAL
}
const
  hh='Begin the Escape execution at the Break of Dawn';
  maxn=4991793;
var
  o:boolean;
  st,fi:string;
  hash:array[0..5000000] of boolean;
  dep,i,j,l1,l2:longint;
function elfhash(s1:string):longint;
var
  i:integer;
  x:longint;
begin
  elfhash:=0;
  x:=0;
  for i:= 1 to length(s1) do
    begin
      elfhash:=(elfhash shl 4)+ord(s1[i]);
      x:=elfhash and $F0000000;
      if x<>0 then
        begin
          elfhash:=elfhash xor (x shr 24);
          elfhash:=elfhash and not x;
        end;
    end;
  elfhash:=elfhash and $7FFFFFFF;
  elfhash:=elfhash mod maxn;
end;
function judge(st:string):boolean;
var
  i,j,l1,l:longint;
  st1,st2:string;
begin
  l:=length(st);
  for i:= 1 to l do
    if st[i]='C' then
      begin
        l1:=i; break;
      end;
  for i:= l1 downto 1 do
    begin
      if (st[i]='O') or (st[i]='W') then exit(false);
    end;
  st1:=copy(st,1,l1-1);
  st2:=copy(fi,1,l1-1);
  if st1<>st2 then exit(false);
  for i:= l downto 1 do
    if st[i]='W' then
      begin
        l1:=i; break;
      end;
  for i:= l1 to l do
    begin
      if (st[i]='O') or (st[i]='C') then exit(false);
    end;
  st1:=copy(st,l1+1,l-l1);
  st2:=copy(fi,length(fi)-(l-l1)+1,l-l1);
  if st1<>st2 then exit(false);

  exit(true);
end;
procedure search(depth:longint; st:string);
var
  i,j,k,l,t,p:longint;
  st1,st2,st3:string;
begin
  if o then exit;
  if depth=0 then
    begin
      if st=fi then
        begin
          o:=true;
        end;
      exit;
    end;
  l:=length(st);
  for i:= 2 to l-1 do
    if st[i]='O' then
      for j:= 1 to i-1 do
        if st[j]='C' then
          for k:= l downto i+1 do
            if st[k]='W' then
              begin
                st1:=copy(st,1,j-1);
                st1:=st1+copy(st,i+1,k-i-1);
                st1:=st1+copy(st,j+1,i-j-1);
                st1:=st1+copy(st,k+1,l-k);
                p:=length(fi);
                t:=elfhash(st1);
                if (depth=1) or (not hash[t]) and judge(st1) then
                  begin
                    hash[t]:=true;
                    search(depth-1,st1);
                  end;
              end;
end;
procedure main;
var
  i,j:longint;
begin
  fillchar(hash,sizeof(hash),0);
  o:=false;
  j:=elfhash(st);
  hash[j]:=true;
  search(dep,st);
  if o then
    begin
      writeln(1,' ',dep);
    end
  else
    writeln(0,' ',0);
end;
procedure init;
var
  i,j,a,b,c:longint;
begin
  readln(st);
  fi:=hh;
  l1:=length(fi);
  l2:=length(st);
  j:=l2-l1;
  o:=true;
  if (l2-l1) mod 3<>0 then
    o:=false;
  a:=0; b:=0; c:=0;
  for i:= 1 to l2 do
    begin
      if st[i]='C' then inc(a);
      if st[i]='O' then inc(b);
      if st[i]='W' then inc(c);
    end;
  if not ((a=b) and (a=c) and (b=c)) then
    o:=false;
  if o then
    begin
     dep:=a; main;
    end
  else
    begin
      writeln(0,' ',0);
    end;
end;
begin
  assign(input,'jj.in'); reset(input);
  //assign(input,'cryptcow.in'); reset(input);
  //assign(output,'cryptcow.out'); rewrite(output);
  init;
  close(input); close(output);
end.