{
ID:kjinxin1
PROG:fence9
LANG:PASCAL
}
var
  ans:longint;
  n,m,p,i,j:longint;
procedure init;
begin
  readln(n,m,p);
end;
procedure main;
var
  i,j,x,l,r:longint;
begin
  ans:=0;
  if n<=p then
    begin
      for x:= 1 to n-1 do
        begin
          if x*m mod n=0 then
            begin
              inc(ans,m*x div n-1);
            end
          else
            inc(ans,trunc(m/n*x));
        end;
      if n<p then
        begin
          j:=n; if n=0 then j:=n+1;
          for x:= j to p-1 do
            begin
              if m*(p-x) mod (p-n)=0 then
                begin
                  inc(ans,m*(p-x) div (p-n)-1);
                end
              else
                inc(ans,trunc(m/(p-n)*(p-x)));
            end;
        end;
    end
  else
    begin
      for x:= 1 to p-1 do
        begin
          if m*x mod n=0 then
            begin
              inc(ans,m*x div n-1);
            end
          else
            inc(ans,trunc(m/n*x));
        end;
      for x:= p to n-1 do
        begin
          if m*x mod n=0 then
            r:=m*x div n-1
          else r:=trunc(m/n*x);
          if m*(p-x) mod (p-n)=0 then
            begin
              l:=m*(p-x) div (p-n)+1;
            end
          else
            l:=trunc(m/(p-n)*(p-x))+1;
          if r-l+1>0 then
            inc(ans,r-l+1);
        end;
    end;
  writeln(ans);
end;
begin
  assign(input,'fence9.in'); reset(input);
  assign(output,'fence9.out'); rewrite(output);
  init;
  main;
  close(input); close(output);
end.