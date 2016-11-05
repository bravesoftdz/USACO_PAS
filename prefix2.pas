{
ID:kjinxin1
PROG:prefix
LANG:PASCAL
}
type
  node=record
    fi,ju:boolean;
    next:longint;
  end;
var
  trie:array[1..10000,'A'..'Z'] of node;
  s:array[1..200000] of char;
  f:array[0..200000] of boolean;
  i,j,top,k,n:longint;
  t,t1:char;
  o:boolean;
begin
  assign(input,'prefix.in');
  reset(input);
  assign(output,'prefix.out');
  rewrite(output);
  fillchar(trie,sizeof(trie),0);
  fillchar(s,sizeof(s),0);
  fillchar(f,sizeof(f),0);
  read(t);
  top:=1;
  while t<>'.' do
    begin
      o:=true;
      j:=1;
      while (t<>' ') and (t<>'.') and o do
        begin
          i:=j;
          t1:=t;
          if trie[j,t].ju then j:=trie[j,t].next
          else
            begin
              inc(top);
              trie[j,t].ju:=true;
              trie[j,t].next:=top;
              j:=top;
            end;
          if eoln then
            begin
              readln;
              o:=false;
            end;
          read(t);
        end;
      while t=' ' do read(t);
      trie[i,t1].fi:=true;
    end;
  readln;
  n:=0;
  while not eof do
    begin
      while not eoln do
        begin
          inc(n);
          read(s[n]);
        end;
      readln;
    end;
  f[0]:=true;
  for i:= 1 to n do
    begin
      if f[i-1] then
        begin
          j:=i; k:=1;
          while (k<>0) and (j<=n) and trie[k,s[j]].ju do
            begin
              if trie[k,s[j]].fi then
                f[j]:=true;
              k:=trie[k,s[j]].next;
              inc(j);
            end;
        end;
    end;
  for i:= n downto 0 do
    begin
      if f[i] then
        begin
           writeln(i);
           break;
        end;
    end;
  close(input);
  close(output);
end.
