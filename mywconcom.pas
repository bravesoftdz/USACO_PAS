{
ID:kjinxin1
PROG:concom
LANG:PASCAL
}
var
  n,i,j,k,t,t1:longint;
  g:array[0..100,0..100] of longint;
  hash1:array[0..100] of boolean;
procedure search(i:longint);
var
  j,k:longint;
begin
  for j:= 1 to t do
    begin
      if (g[i,j]>50) and (i<>j) then
        begin
          if not hash1[j] then
            begin
              hash1[j]:=true;
              search(j);
            end;
          for k:= 1 to t do
            begin
              if (i<>k) and (k<>j) then inc(g[i,k],g[j,k]);
            end;
        end;
    end;
end;
begin
  assign(input,'jj.in');
  reset(input);
  {assign(input,'concom.in');
  reset(input);
  assign(output,'concom.out');
  rewrite(output);               }
  fillchar(g,sizeof(g),0);
  fillchar(hash1,sizeof(hash1),0);
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
      if not hash1[i] then search(i);
    end;
  for i:= 1 to t do
    for j:= 1 to t do
      begin
        if (g[i,j]>50) and (i<>j) then
          begin
            writeln(i,' ',j);
          end;
      end;
  close(input); close(output);
end.
