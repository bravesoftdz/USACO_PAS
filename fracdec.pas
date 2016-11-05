{
ID:kjinxin1
PROG:fracdec
LANG:PASCAL
}
var
  m,n,i,j:longint;
  a:array[0..100000] of longint;
  top,dep,shou,lt:longint;
  o:boolean;
  st:string;
procedure dfs(m:longint);
var
  i,j:longint;
begin
  while not o and (m<>0) and (top<100000) do
    begin
      inc(top);
      m:=m*10;
      a[top]:= m div n;
      m:=m mod n;
      if m=0 then o:=true;
    end;
end;

procedure dfs1(dep,shou:longint);
var
  i,j:longint;
  u:boolean;
begin
  u:=true;
  for j:= 1 to 4 do
    begin
      if not o then break;
      if not u then break;
      for i:= shou to shou+dep-1 do
        begin
          if i+dep*j>100000 then
            begin
              u:=false; break;
            end;
          if(a[i]=a[i+dep*j]) then
            continue
          else
            begin
              o:=false;
              break;
            end;
        end;
    end;
end;
begin
  assign(input,'fracdec.in');
  reset(input);
  assign(output,'fracdec.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  readln(m,n);
  top:=1;
  a[top]:= m div n;  str(a[top],st); lt:=length(st);
  m:=m mod n; o:=false;
  if m=0 then
    begin
      o:=true;
      inc(top); a[top]:=0;
    end
  else
    dfs(m);
  if o then
    begin
      write(a[1],'.');
      for i:= 2 to top do
        begin
          write(a[i]);
        end;
      writeln;
    end
  else
    begin
      for dep:= 1 to 100000 do
        begin
          if o then break;
          for shou:= 2 to 100 do
            begin
              o:=true;
              dfs1(dep,shou);
              if o then break;
            end;
        end;
      dec(dep);
      write(a[1],'.');  inc(lt);
      for i:= 2 to shou-1 do
        begin
          if lt mod 76=0 then writeln;
          write(a[i]);
          inc(lt);
        end;
      write('(');  inc(lt);
      for i:= shou to shou+dep-1 do
        begin
          if lt mod 76=0 then writeln;
          write(a[i]);
          inc(lt);
        end;
      writeln(')');
    end;
  close(input); close(output);
end.