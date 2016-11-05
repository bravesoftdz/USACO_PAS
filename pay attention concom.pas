{
ID:kjinxin1
PROG:concom
LANG:PASCAL
}
var
  n,i,j,k,t,t1:longint;
  g:array[0..100,0..100] of longint;
  hash:array[0..100] of boolean;
  cx:array[0..100] of longint;
procedure dfs(p:longint);
var
  i,j:longint;
begin
  if hash[p] then exit;
  hash[p]:=true;
  for i:= 1 to t do
    begin
      if p<>i then
        begin
          inc(cx[i],g[p,i]);
          if cx[i]>50 then
            dfs(i);
        end;
    end;
end;
begin
  assign(input,'concom.in');
  reset(input);
  assign(output,'concom.out');
  rewrite(output);  
  fillchar(g,sizeof(g),0);
  fillchar(hash,sizeof(hash),0);
  readln(n); t:=0;
  for i:= 1 to n do
    begin
      read(j,k);
      if (j>=k) and (j>t) then
        begin
          t:=j;
        end;
      if (k>j) and (k>t) then t:=k;
      readln(t1);
      inc(g[j,k],t1);
    end;
  for i:= 1 to t do
    begin
      fillchar(hash,sizeof(hash),0);
      fillchar(cx,sizeof(cx),0);
      dfs(i);
      for j:= 1 to t do
        begin
          if (i<>j) and (cx[j]>50) then writeln(i,' ',j);
        end;
    end;
  close(input); close(output);
end.
