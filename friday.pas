{ID:kjinxin1
PROG:friday
LANG:PASCAL
}
var
  hash:array[0..6] of longint;
  t,i,j,n:longint;
begin
  assign(input,'friday.in');
  reset(input);
  assign(output,'friday.out');
  rewrite(output);
  fillchar(hash,sizeof(hash),0);
  readln(n);
  t:=1;
  for i:= 1900 to 1900+n-1 do
    begin
      for j:= 1 to 12 do
        begin
          inc(hash[(t+12) mod 7]);
          case j of
            1,3,5,7,8,10,12:
              t:=(t+31) mod 7;
            4,6,9,11:
              t:=(t+30) mod 7;
            2:
              begin
                if (i mod 4=0) and (i mod 100<>0) or (i mod 400=0) then
                  t:=(t+29) mod 7
                else
                  t:=(t+28) mod 7;
              end;
          end;
        end;
    end;
  write(hash[6],' ');
  for i:= 0 to 4 do
    write(hash[i],' ');
  writeln(hash[5]);
  close(input);
  close(output);
end.