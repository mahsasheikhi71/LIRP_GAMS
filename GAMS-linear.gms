sets
i/1*2/
h/1*5/
t/1*3/
p/1/
v/1*6/
r/1*2/
j(h)/1,2/
k(h)/3,4,5/
q/1*3/
rr/1,2,3,4,5,6,7,8,9,10/ ;

alias(h,kp);
alias(r,rp);
alias(k,hp);
alias(t,tp);

scalar BigM/1000000/;
scalar Tomax/3/;
scalar Capacity/400/;
scalar Tmax/20/;
scalar Av/70/;
scalar Vc/20/;

parameter
zarib1(rr)
/1  30
 2  40
 3  50
 4  60
 5  70
 6  80
 7  90
 8  100
 9  110
 10 120
/
zarib2(rr)
/1   0.000000150870346714
 2   0.000009205439487377
 3   0.000345863281904110
 4   0.008001726084602130
 5   0.113994052842122000
 6   1.000000000000000000
 7   5.401782544865870000
 8   17.967741298668700000
 9   36.801808942023000000
 10  46.415618119545000000
/
zarib3(rr)
/1  1119.674
 2  969.428
 3  856.681
 4  782.741
 5  752.672
 6  772.677
 7  849.383
 8  989.608
 9  1200.251
 10 1488.265
/;

Parameter
G(p)
/1 1/;

Parameter
F(j)
/1 100
 2 100/;

table
sc(p,q)
    1    2    3
1   7    5    1;

table
os(i,j)
   1   2
1  12  10
2  10  12;

table hc(j,p)
     1
1    0.1
2    0.1;

table
d(h,kp)
     1      2      3      4      5
1    100    550    550    550    550
2    550    100    550    550    550
3    550    550    100    550    550
4    550    550    550    100    550
5    550    550    550    550    100;

table
tc(h,kp)
     1     2     3     4     5
1    0.05  0.05  0.05  0.05  0.05
2    0.05  0.05  0.05  0.05  0.05
3    0.05  0.05  0.05  0.05  0.05
4    0.05  0.05  0.05  0.05  0.05
5    0.05  0.05  0.05  0.05  0.05;

table
Demand(k,p,t)
       1     2    3
3.1    10    10   70
4.1    10    10   10
5.1    10    10   10;

table
c(i,p)
     1
1    50
;

parameter
ps(p)
/1 2/;

parameters
ca(j)
/1 70
 2 70/;

positive variable
S(j,p,q,t)
II(j,k,p,q,t)
orr(i,j,p,t)
O(j,k,p,t)
u
M(k,v,r,t)


l(rr)
ll(rr,h,kp,v,r,t);

u.lo=30;
u.up=120;

binary Variables
NVr(v,r,t)
NV(v,t)
B(j,k)
BP(i,j)
A(j)
X(kp,h,v,r,t)
Z(i,j,t)
w(j,p,q,t)
wo(j,p,t)

aa(rr);


free variable
Profit
PP
Cost1
Cost2
Cost3
Cost4
Cost5
Cost6
f2
f3
total;

equations
MainObj,Cn1,Cn2,Cn3,Cn4,Cn5,Cn6,Cn7,Cn8,Cn9,Cn10,Cn11,Cn12,Cn13,Cn14,Cn15,Cn16,Cn17,Cn18,Cn181,Cn182,Cn19,Cn20,Cn21,Cn22,Cn23,Cn24,Cn241,Cn25,Cn26,Cn27,Cn28,Cna1,Cna2,Cna3,Cna4,Cna5,Cna6,Cna7
totalobj
obj2
obj3
constraint1
constraint2
constraint3
constraint4
constraint5
constraint6
constraint7
constraint8
constraint9
constraint10

;

totalobj..total=e=f3;
MainObj..Profit=e=sum(j,sum(p,sum(q$(ord(q) ge 2),sum(k,sum(t,SC(p,q)*II(j,k,p,q,t))))))+sum(j,sum(k,sum(p,sum(t,O(j,k,p,t)*SC(p,"1")))))-(sum(t,sum(j,sum(p,sum(q,hc(j,p)*S(j,p,q,t)))))+sum(j,F(j)*A(j))+sum((r,t,v,h,kp),d(h,kp)*tc(h,kp)*X(h,kp,v,r,t))+sum((t,j,i,p),orr(i,j,p,t)*ps(p))+sum((t,v),vc*NV(v,t))+sum(i,sum(j,sum(t,Z(i,j,t)*os(i,j)))));
Cn1(k)..sum(j,B(j,k))=e=1;
Cn2(t,k)..sum(r,sum(h,sum(v,X(h,k,v,r,t))))=e=1;
Cn3(t,v,r)..sum(j,sum(k,X(j,k,v,r,t)))=l=1;
Cn4(h,v,t,r)..sum(kp,X(kp,h,v,r,t))-sum(kp,X(h,kp,v,r,t))=e=0;
Cn5(v,t)..sum(r,sum(kp,sum(h,X(kp,h,v,r,t)*d(h,kp))))=l=Tmax*u;
Cn6(kp,h,v,r,t)$(ord(r) le card(r)-1)..Nvr(v,r+1,t)=l=Nvr(v,r,t);
Cn7(v,j,r,t)$(ord(r) le card(r)-1)..sum(h,x(j,h,v,r+1,t))=l=sum(h,x(j,h,v,r,t));
Cn8(v,r,t)..sum(j,sum(h,X(j,h,v,r,t)))=l=BigM*Nvr(v,r,t);
Cn9(v,r,t)..NVr(v,r,t)=l=Nv(v,t);
Cn10(v,j,k,t,r)..sum(h,X(k,h,v,r,t))+sum(h,X(j,h,v,r,t))-B(j,k)=l=1;
Cn11(k,hp,v,t,r)..M(k,v,r,t)-M(hp,v,r,t)+card(k)*X(k,hp,v,r,t)=l=Card(k)-1;
Cn12(j,p,t,q)$(ord(q) le card(q)-1 and ord(t) ge 2)..S(j,p,q+1,t)=e=S(j,p,q,t-1)-sum(k,II(j,k,p,q,t));
Cn13(j,p,t)..S(j,p,"1",t)=e=sum(i,orr(i,j,p,t))-sum(k,o(j,k,p,t));
Cn14(j,p,q)$(ord(q) ge 2)..S(j,p,q,"1")=e=0;
Cn15(j,k,p,q)..II(j,k,p,q,"1")=e=0;
Cn16(j,p,t)..S(j,p,"1",t)=l=sum(tp$(ord(tp) ge ord(t)+1 and ord(tp) le ord(t)+Tomax-1),sum(k,Demand(k,p,t)*B(j,k)));
Cn17(j,k,p,t)..Demand(k,p,t)*B(j,k)=e=sum(q,II(j,k,p,q,t))+o(j,k,p,t);
Cn18(j,p,q,t)$(ord(t) ge 2)..sum(k,II(j,k,p,q,t))=l=S(j,p,q,t-1);
Cn181(j,p,k,t)..o(j,k,p,t)=l=BigM*B(j,k);
Cn182(j,k,p,q,t)..II(j,k,p,q,t)=l=BigM*B(j,k);
Cn19(j,p,q,t)..w(j,p,q,t)*BigM=l=sum(k,II(j,k,p,q,t));
Cn20(j,p,t)..wo(j,p,t)*BigM=l=sum(k,o(j,k,p,t));
Cn21(j,p,q,t)$(ord(q) le card(q)-1)..w(j,p,q+1,t)=l=w(j,p,q,t);
Cn22(j,p,t)..w(j,p,"1",t)=l=wo(j,p,t);
Cn23(v,r,t)..sum(h,sum(k,sum(p,Demand(k,p,t)*X(h,k,v,r,t)*G(p))))=l=Capacity;
Cn24(j,t)$(ord(t) ge 2)..sum(p,(sum(i,orr(i,j,p,t)*G(p))+sum(q,S(j,p,q,t-1))))=l=Ca(j)*A(j);
Cn241(j)..sum(p,(sum(i,orr(i,j,p,"1")*G(p))))=l=Ca(j)*A(j);
Cn25(i,j,p,t)..orr(i,j,p,t)=l=BigM*Bp(i,j);
Cn26(i,p,t)..sum(j,orr(i,j,p,t))=l=c(i,p);
Cn27(i,j,t)..sum(p,orr(i,j,p,t))=l=BigM*Z(i,j,t);
Cn28(j)..sum(i,sum(t,Z(i,j,t)))=l=BigM*A(j);

Cna1..PP=e=sum(j,sum(p,sum(q$(ord(q) ge 2),sum(t,Sc(p,q)*sum(k,II(j,k,p,q,t))))))+sum(j,sum(p,sum(t,sum(k,O(j,k,p,t))*SC(p,"1"))));
Cna2..Cost1=e=sum(t,sum(j,sum(p,sum(q,hc(j,p)*S(j,p,q,t)))));
Cna3..Cost2=e=sum(j,F(j)*A(j));
Cna4..Cost3=e=sum((r,t,v,h,kp),d(h,kp)*tc(h,kp)*X(h,kp,v,r,t));
Cna5..Cost4=e=sum((t,j,i,p),orr(i,j,p,t)*ps(p));
Cna6..Cost5=e=sum((t,v),vc*NV(v,t));
Cna7..Cost6=e=sum(i,sum(j,sum(t,Z(i,j,t)*os(i,j))));

obj2..                            f2=E=sum((h,kp,v,r,t,rr),zarib2(rr)*ll(rr,h,kp,v,r,t));
obj3..                            f3=E=sum((h,kp,v,r,t,rr),zarib3(rr)*ll(rr,h,kp,v,r,t)*d(h,kp));

constraint1..                     u=E=sum(rr,zarib1(rr)*l(rr));
constraint2(rr)..                 l(rr)=L=1;
constraint3(rr,h,kp,v,r,t)..      ll(rr,h,kp,v,r,t)=L=1;
constraint4..                     sum(rr,l(rr))=E=1;
constraint5(rr,h,kp,v,r,t)..      ll(rr,h,kp,v,r,t)=L=l(rr);
constraint6(rr,h,kp,v,r,t)..      ll(rr,h,kp,v,r,t)=L=x(h,kp,v,r,t);
constraint7(rr,h,kp,v,r,t)..      l(rr)+x(h,kp,v,r,t)-1=L=ll(rr,h,kp,v,r,t);
constraint8..                     l('1')=L=aa('1');
constraint9(rr,h,kp,v,r,t)$(ord(rr) ge 2)..      l(rr)=L=aa(rr-1)+aa(rr);
constraint10..        sum(rr,aa(rr))=E=1;




option limrow=0;
option limcol=0;
option optcr=0;
model Sheikhi/All/;
option reslim=6000;
solve Sheikhi using MIP minimizing total;
display total.l,z.l,x.l,b.l,a.l,s.l,ii.l,o.l,orr.l,NV.l,PP.l,u.l,Cost1.l,Cost2.l,Cost3.l,Cost4.l,Cost5.l,Cost6.l;
