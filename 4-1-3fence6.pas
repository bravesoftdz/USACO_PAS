{
ID:kjinxin1
PROG:fence6
LANG:PASCAL
}
const
  maxn=1000000010;
type
  node=record
    a,b:array[0..100] of longint;
  end;
var
  hash:array[1..200,1..200] of longint;
  l,num1,num2:array[0..100] of longint;
  g:array[0..100] of node;
  h:array[0..100,0..1] of longint;
  a:array[0..100] of longint;
  visit:array[0..100] of boolean;
  ans:array[0..100] of longint;
  top,s,n,min:longint;
procedure init;
var
  i,j,s:longint;
begin
  fillchar(hash,sizeof(hash),$ff);
  fillchar(l,sizeof(l),0);
  fillchar(num1,sizeof(num1),0);
  fillchar(num2,sizeof(num2),0);
  fillchar(g,sizeof(g),0);
  fillchar(h,sizeof(h),0);
  fillchar(visit,sizeof(visit),0);
  fillchar(a,sizeof(a),0);
  readln(n);
  for i:= 1 to n do
    begin
      read(s); read(l[s],num1[s],num2[s]);
      for j:= 1 to num1[s] do
        begin
          read(g[s].a[j]);
        end;
      readln;
      for j:= 1 to num2[s] do
        begin
          read(g[s].b[j]);
        end;
      readln;
    end;
end;
procedure dfs(u:longint);
var
  i,j,v:longint;
begin
  visit[u]:=true;
  if (h[u,0]<>0) and (h[u,1]<>0) then
    begin
      hash[h[u,0],h[u,1]]:=l[u]; hash[h[u,1],h[u,0]]:=l[u];
      exit;
    end;
  if h[u,0]=0 then
    begin
      inc(top); h[u,0]:=top;
    end;
  if h[u,1]=0 then
    begin
      inc(top); h[u,1]:=top;
    end;
  hash[h[u,0],h[u,1]]:=l[u]; hash[h[u,1],h[u,0]]:=l[u];
  for i:= 1 to num1[u] do
    begin
      v:=g[u].a[i];
      if (h[v,0]=0) and (h[v,1]<>h[u,1]) and (h[v,1]<>h[u,0]) then
        h[v,0]:=top
      else
      if (h[v,1]=0) and (h[v,0]<>h[u,1]) and (h[v,0]<>h[u,0]) then
        h[v,1]:=top;
    end;
  for i:= 1 to num2[u] do
    begin
      v:=g[u].b[i];
      if (h[v,0]=0) and (h[v,1]<>h[u,1]) and (h[v,1]<>h[u,0]) then
        h[v,0]:=top
      else
      if (h[v,1]=0) and (h[v,0]<>h[u,1]) and (h[v,0]<>h[u,0]) then
        h[v,1]:=top;
    end;
  for i:= 1 to num1[u] do
    begin
      v:=g[u].a[i];
      if not visit[v] then
        dfs(v);
    end;
  for i:= 1 to num2[u] do
    begin
      v:=g[u].b[i];
      if not visit[v] then
        dfs(v);
    end;
end;
procedure change;
var
  i,j,w,v:longint;
begin
  for i:= 1 to n do
    begin
      if not visit[i] then
        begin
          visit[i]:=true;
          inc(top); h[i,0]:=top; inc(top); h[i,1]:=top;
          hash[h[i,0],h[i,1]]:=l[i]; hash[h[i,1],h[i,0]]:=l[i];
          for j:= 1 to num1[i] do
            begin
              v:=g[i].a[j];
              h[v,0]:=top-1;
            end;
          for j:= 1 to num2[i] do
            begin
              v:=g[i].b[j];
              h[v,0]:=top;
            end;
          for j:= 1 to num1[i] do
            begin
              v:=g[i].a[j];
              if not visit[v] then dfs(v);
            end;
          for j:= 1 to num2[i] do
            begin
              v:=g[i].a[j];
              if not visit[v] then dfs(v);
            end;
        end;
    end;
end;
function try1(u,v:longint):longint;
var
  i,j,w,l,r:longint;
begin
  fillchar(visit,sizeof(visit),0);
  for i:= 1 to top do
    ans[i]:=maxn;
  ans[u]:=0;
  l:=1; r:=1; a[l]:=u; visit[u]:=true;
  while l<=r do
    begin
      w:=a[l];
      for i:= 1 to top do
        begin
          if (hash[w,i]<>-1) and (ans[w]+hash[w,i]<ans[i]) then
            begin
              ans[i]:=ans[w]+hash[w,i];
              if not visit[i] then
                begin
                  inc(r); a[r]:=i;
                end;
            end;
        end;
      visit[w]:=false;
      inc(l);
    end;
  exit(ans[v]);
end;
procedure main;
var
  i,j,t,k:longint;
begin
  change;
  min:=maxn;
  for i:= 1 to top do
    for j:= 1 to top do
      begin
        if hash[i,j]<>-1 then
          begin
            t:=hash[i,j];
            hash[i,j]:=-1;
            k:=try1(i,j);
            hash[i,j]:=t;
            if k+hash[i,j]<min then min:=k+hash[i,j];
          end;
      end;
  writeln(min);
end;
begin
  assign(input,'fence6.in'); reset(input);
  assign(output,'fence6.out'); rewrite(output);
  init;
  main;
  close(input); close(output);
end.