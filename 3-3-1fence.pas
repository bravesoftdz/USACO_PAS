{
ID:kjinxin1
PROG:fence
LANG:PASCAL
}
type
  node=record
    x,y:longint;
  end;
  node1=record
    st,fi,ti:longint;
  end;
var
  ans:array[0..10000] of longint;
  g:array[0..10000] of node;
  xin:array[0..10000] of node1;
  hash:array[0..500,0..500] of longint;
  f,i,j,x,y,top:longint;
  o:boolean;
procedure paixu(m,n:longint);
var
  l1,l2,x,y:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1].x;
  y:=g[(l1+l2) shr 1].y;
  repeat
    while (g[l1].x<x) or (g[l1].x=x) and (g[l1].y<y) do inc(l1);
    while (g[l2].x>x) or (g[l2].x=x) and (g[l2].y>y) do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1]; g[l1]:=g[l2]; g[l2]:=t;
        inc(l1); dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;
procedure dfs(t:longint);
var
  i,j,p,q:longint;
begin
  for i:= xin[t].st to xin[t].fi do
    begin
      if hash[t,g[i].y]>0 then
        begin
          dec(hash[t,g[i].y]); dec(hash[g[i].y,t]);
          inc(xin[t].ti);
          inc(xin[g[i].y].ti);
          dfs(g[i].y);
        end;
    end;
  inc(ans[0]);
  ans[ans[0]]:=t;
end;
procedure print;
var
  i,j:longint;
begin
  for i:= ans[0] downto 1 do
    writeln(ans[i]);
end;
begin
  assign(input,'fence.in'); reset(input);
  assign(output,'fence.out'); rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(xin,sizeof(xin),0);
  fillchar(ans,sizeof(ans),0);
  fillchar(hash,sizeof(hash),0);
  readln(f); top:=0;
  for i:= 1 to f do
    begin
      readln(x,y);
      inc(top);
      g[top].x:=x; g[top].y:=y;
      inc(top);
      g[top].y:=x; g[top].x:=y;
      inc(hash[x,y]); inc(hash[y,x]);
    end;
  paixu(1,top);
  for i:= 1 to top do
    begin
      if g[i].x<>g[i-1].x then
        begin
          xin[g[i-1].x].fi:=i-1;
          xin[g[i].x].st:=i;
          xin[g[i].x].ti:=i;
        end;
    end;
  xin[g[top].x].fi:=top;  o:=false;
  for i:= 1 to 500 do
    begin
      if ((xin[i].fi-xin[i].st+1) and 1=1) and (xin[i].st<>0) then
        begin
          o:=true; j:=i; break;
        end;
    end;
  if o then dfs(j)
  else dfs(1);
  print;
  close(input); close(output);
end.