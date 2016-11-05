{
ID:kjinxin1
PROG:sort3
LANG:PASCAL
}
var
  n:longint;
  g:array[0..1000] of integer;
  hash:array[1..3] of integer;
  i,j,ans,t:longint;
begin
  assign(input,'sort3.in');
  reset(input);
  assign(output,'sort3.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(hash,sizeof(hash),0);
  readln(n);
  for i:= 1 to n do
    begin
      readln(g[i]);
      inc(hash[g[i]]);
    end;
  for i:= 1 to hash[1] do
    begin
      if g[i]=2 then
        begin
          for j:= hash[1]+1 to hash[1]+hash[2] do
            begin
              if g[j]=1 then
                begin
                  inc(ans);
                  t:=g[i]; g[i]:=g[j]; g[j]:=t;
                  break;
                end;
            end;
        end;
      if g[i]=3 then
        begin
          for j:= hash[1]+hash[2]+1 to n do
            begin
              if g[j]=1 then
                begin
                  inc(ans);
                  t:=g[i]; g[i]:=g[j]; g[j]:=t;
                  break;
                end;
            end;
        end;
    end;
  for i:= hash[1]+1 to hash[1]+hash[2] do
    begin
      if g[i]=3 then
        begin
          for j:= hash[1]+hash[2]+1 to n do
            begin
              if  g[j]=2 then
                begin
                  inc(ans);
                  t:=g[i]; g[i]:=g[j]; g[j]:=t;
                  break;
                end;
            end;
        end;
    end;
  for i:= 1 to hash[1] do
    begin
      if g[i]<>1 then
        begin
          for j:= hash[1]+1 to n do
            begin
              if g[j]=1 then
                begin
                  inc(ans);
                  t:=g[i]; g[i]:=g[j]; g[j]:=t;
                  break;
                end;
            end;
        end;
    end;
  for i:= hash[1]+1 to hash[1]+hash[2] do
    begin
      if g[i]<>2 then
        begin
          for j:= hash[1]+hash[2]+1 to n do
            begin
              if g[j]=2 then
                begin
                  inc(ans);
                  t:=g[i]; g[i]:=g[j]; g[j]:=t;
                  break;
                end;
            end;
        end;
    end;
  writeln(ans);
  close(input);
  close(output);
end.