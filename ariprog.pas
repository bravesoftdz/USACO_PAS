{
ID:kjinxin1
PROG:ariprog
LANG:PASCAL
}
type
  node=record
    a,b:longint;
  end;
var
  m,n,i,j,num,sum:longint;
  hash:array[0..250*250*2] of integer;
  g:array[0..250*250*2] of longint;
  ans:array[0..10000] of node;
procedure paixu1(m,n:longint);
var
  l1,l2,t,x:longint;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1];
  repeat
    while g[l1]<x do inc(l1);
    while g[l2]>x do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1];
        g[l1]:=g[l2];
        g[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu1(l1,n);
  if l2>m then paixu1(m,l2);
end;
procedure init;
var
  i,j,t:longint;
begin
  num:=1;
  hash[0]:=1; g[1]:=0;
  for i:= 0 to m do
    for j:= 0 to m do
      begin
        t:=sqr(i)+sqr(j);
        if hash[t]=0 then
          begin
            hash[t]:=1;
            inc(num);
            g[num]:=t;
          end;
      end;
  paixu1(1,num);
end;
procedure search;
var
  i,j,t,p,l:longint;
  o:boolean;
begin
  sum:=0;
  for i:= 1 to num-n do
    begin
      for j:= i+1 to num-n+1 do
        begin
          t:=g[j]-g[i];
          p:=g[i]; o:=true;
          for l:= 1 to n-1 do
            begin
              p:=p+t;
              if (p>g[num]) or (hash[p]=0) then
                begin
                  o:=false;
                  break;
                end;
            end;
          if o then
            begin
              inc(sum);
              ans[sum].a:=g[i]; ans[sum].b:=t;
            end;
        end;
    end;
end;
procedure paixu;
var
  i,j:longint;
  t:node;
begin
  for i:= 1 to sum-1 do
    for j:= sum downto i+1 do
      begin
        if (ans[j].b<ans[j-1].b) or (ans[j].b=ans[j-1].b) and (ans[j].a<ans[j-1].a) then
          begin
            t:=ans[j];
            ans[j]:=ans[j-1];
            ans[j-1]:=t;
          end;
      end;
end;
procedure print;
var
  i,j:longint;
begin
  for i:= 1 to sum do
    begin
      writeln(ans[i].a,' ',ans[i].b);
    end;
  if sum=0 then writeln('NONE');
end;
begin
  {assign(input,'ariprog.in');
  reset(input);
  assign(output,'ariprog.out');
  rewrite(output);   }
  assign(input,'jj.in');
  reset(input);
  fillchar(hash,sizeof(hash),0);
  fillchar(g,sizeof(g),0);
  fillchar(ans,sizeof(ans),0);
  readln(n); readln(m);
  init;
  search;
  paixu;
  print;
  close(input);
  close(output);
end.