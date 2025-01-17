#version 330

uniform sampler2D textureMap0;
uniform sampler2D textureMap1;

out vec4 pixelColor; //Zmienna wyjsciowa fragment shadera. Zapisuje sie do niej ostateczny (prawie) kolor piksela

#define N 2

in vec4 l[N];
in vec4 n;
in vec4 v;
in vec2 iTexCoord0;
in vec2 iTexCoord1;


void main(void) {

vec4 ml[N];
vec4 mr[N];
float nl[N];
float rv[N];
vec4 pixelPartialSum = vec4(0,0,0,0);

//pobieramy l n i v do lokalnych zmiennych i normalizujemy

//Bez zmian
vec4 mn = normalize(n);
vec4 mv = normalize(v);

  //Sumujemy wszystkie �r�d�a �wiat�a:
  for (int i=0;i<N;i++) {
        ml[i] = normalize(l[i]);
        mr[i] = reflect(-ml[i],mn);
        nl[i] = clamp( dot(mn,ml[i]),0,1);
        rv[i] = pow(clamp(dot(mr[i],mv),0,1), 25); 
  }

   vec4 kd = mix(texture(textureMap0,iTexCoord0),texture(textureMap1,iTexCoord1),0.3);
   vec4 ks= vec4(1,1,1,1);
   //zakladamy ze kolory ls i ks to kolor bialy wiec brak we wzorze

   //Obliczamy sume czesciow�
     for (int i=0;i<N;i++) {

        pixelPartialSum += vec4(kd.rgb * nl[i],kd.a)+vec4(ks.rgb*rv[i],0);
     }

    //Suma wszystkich to nasz pixel color
	pixelColor = pixelPartialSum;
}
