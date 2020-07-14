#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"

extern void idfun(void);
extern void namefun(void);
extern char team[10];
extern char name1[20], name2[20], name3[20];
extern int summ;
extern int num1, num2, num3;
extern void drawJS(int cX, int cY, int width, int height, int16_t frame[FRAME_HEIGHT][FRAME_WIDTH]);


/*************************************************************
 *  <<Julia set相關資料>>
 *  https://en.wikipedia.org/wiki/Julia_set
 *
 *  cX 為 Julia set數學式中複數 "c" 的實部
 *  cY 為 Julia set數學式中複數 "c" 的虛部
 *  調整cX(值域:-1.0~1.0)與cY(值域:0.0~1.0)可得到不同的圖形
 *
 
*************************************************************/


int main()
{
	//RGB16 
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;


	printf( "Function1: Name\n" );

	//Dummy Function. Please refer to the specification of Project 1.
	namefun();
	
	printf( "Function2: ID\n" );
	
	//Dummy Function. Please refer to the specification of Project 1.
	idfun();

	//Dummy printout. Please refer to the specification of Project 1. 
	printf( "Main Function:\n" );
	printf( "*****Print All*****\n" );
	// printf( "Team 01\n" );
	printf( "%s", team );
	/*
	printf( "10027001   Peter Huang\n" );
	printf( "10027002   Mary Sue\n" );
	printf( "10027003   Tom Smith\n" );
	*/
	printf( "%d %s", num1, name1 );
	printf( "%d %s", num2, name2 );
	printf( "%d %s", num3, name3 );
	printf( "ID Summation = " );
	printf( "%d\n", summ );
	printf( "*****End Print*****\n" );

	
	printf( "\n***** Please enter p to draw Julia Set animation *****\n" );
	// 等待使用者輸入正確指令
	while(getchar()!='p') {}

	// 清除畫面
	system( "clear" );

	// 打開 Frame Buffer 硬體裝置的Device Node，準備之後的驅動程式呼叫
	fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

	if( fd<0 )
	{	printf( "Frame Buffer Device Open Error!!\n" );	}
	else
	{
		for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {

			// 計算目前cX,cY參數下的Julia set畫面			
			drawJS( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );

			// 透過低階I/O操作呼叫Frame Buffer的驅動程式
			// (將畫面資料寫入Frame Buffer)
			write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );

			// 移動檔案操作位置至最前端，以便下一次的畫面重新寫入
			lseek( fd, 0, SEEK_SET );
		}


		//Dummy printout. Please refer to the specification of Project 1. 
		
		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
		printf( "by Team 10\n" );
		printf( "%d %s", num1, name1 );
		printf( "%d %s", num2, name2 );
		printf( "%d %s", num3, name3 );
		/*
		printf( "10027001   Peter Huang\n" );
		printf( "10027002   Mary Sue\n" );
		printf( "10027003   Tom Smith\n" );
		*/
		
		// 關閉 Device Node檔案，結束驅動程式的使用
		close( fd );
	}

	// 等待使用者輸入正確指令
	printf( "Please enter 'p' to end the program." );
	while(getchar()!='p') {}

	return 0;
}
