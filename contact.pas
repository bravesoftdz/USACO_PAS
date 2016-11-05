{
ID:kjinxin1
PROG:contact
LANG:PASCAL
}
type
  node=record
    time:longint;
    data:char;
    o:boolean;
  end;
  node1=record
    time:longint;
    ch:string;
  end;
var
  a,b,n,k,l,sum,i,j,num,top,max:longint;
  g:array[0..100000] of node;
  h:array[0..200000] of char;
  f:array[0..100000] of longint;
  ch:string;
  ans:array[0..10000] of node1;
  t:node1;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:longint;
begin
  l1:=m; l2:=n; x:=f[(l1+l2) shr 1];
  repeat
    while f[l1]>x do inc(l1);
    while f[l2]<x do dec(l2);
    if l1<=l2 then
      begin
        t:=f[l1]; f[l1]:=f[l2]; f[l2]:=t; inc(l1); dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if m<l2 then paixu(m,l2);
end;
procedure search(t,top:longint);
var
  i,j:longint;
begin
  if not g[t].o  then exit;
  ch:=ch+g[t].data;
  if g[t].time>=k then
    begin
      inc(sum);
      ans[sum].time:=g[t].time;
      ans[sum].ch:=ch;
    end;
  search(2*t,top+1);
  search(2*t+1,top+1);
  delete(ch,top,1);
end;
function min(m,n:longint):longint;
begin
  if m<n then exit(m) else exit(n);
end;
begin
  assign(input,'contact.in');
  reset(input);
  assign(output,'contact.out');
  rewrite(output);
  readln(a,b,n); sum:=0;
  fillchar(g,sizeof(g),0); num:=0;
  while not eof do
    begin
      while not eoln do
        begin
          inc(num);
          read(h[num]);
        end;
      readln;
    end;
  for i:= 1 to num do
    begin
      j:=0; top:=1;
      while j<b do
        begin
          inc(j);
          if i+j-1>num then break;
          if h[i+j-1]='0' then
            begin
              top:=2*top; if top>max then max:=top;
              g[top].data:='0';
              g[top].o:=true;
              if j>=a then inc(g[top].time);
            end
          else
            begin
             top:=2*top+1;if top>max then max:=top;
             g[top].data:='1';
             g[top].o:=true;
             if j>=a then inc(g[top].time);
            end;
        end;
    end;
  for i:= 1 to max do
    begin
      f[i]:=g[i].time;
    end;
  k:=0;  j:=0;
  paixu(1,max);
  while (k<n) and (j<max) and (f[j+1]<>0) do
    begin
      inc(j);
      if f[j]<>f[j-1] then inc(k);
    end;
  k:=f[j];
  ch:='';
  search(2,1);
  ch:='';
  search(3,1);
  for i:= 1 to sum-1 do
    for j:= sum downto i+1 do
      begin
        if (ans[j-1].time<ans[j].time) or (ans[j-1].time=ans[j].time) and (length(ans[j-1].ch)>length(ans[j].ch)) or
           (ans[j-1].time=ans[j].time) and (length(ans[j-1].ch)=length(ans[j].ch)) and (ans[j-1].ch>ans[j].ch) then
          begin
            t:=ans[j];
            ans[j]:=ans[j-1];
            ans[j-1]:=t;
          end;
      end;
  i:=1;
  while i<=sum do
    begin
      writeln(ans[i].time);
      j:=i+1;
      while ans[j].time=ans[i].time do
        begin
          inc(j);
        end;
      for k:= i to j-2 do
        begin
          write(ans[k].ch);
          if (k-i+1) mod 6=0 then writeln
          else write(' ');
        end;
      writeln(ans[j-1].ch);
      i:=j;
    end;
  close(input); close(output);
end.
