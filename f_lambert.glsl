#version 330

uniform sampler2D textureMap0;

out vec4 pixelColor; //Zmienna wyjsciowa fragment shadera. Zapisuje sie do niej ostateczny (prawie) kolor piksela

#define N 2

in vec4 l[N];
in vec4 n;
in vec4 v;
in vec2 iTexCoord0;



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
        nl[i] = clamp( dot(mn,ml[i]),0,1);
  }

   vec4 kd=texture(textureMap0,iTexCoord0);

   //Obliczamy sume czesciow�
     for (int i=0;i<N;i++) {

        pixelPartialSum += vec4(kd.rgb * nl[i],kd.a);
     }

    //Suma wszystkich to nasz pixel color
	pixelColor = pixelPartialSum;
}
