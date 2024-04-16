#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // 전달받은 명령행 인수 중 첫 번째 인수를 도메인으로 저장
    char *domain = argv[1];
    struct addrinfo *addresses;
    struct addrinfo hints;
    memset(&hints,0,sizeof(hints));
    
    hints.ai_family = AF_UNSPEC;        // IPv4, IPv6 주소 모두를 허용하도록 설정
    hints.ai_socktype = SOCK_STREAM;    // TCP 소켓을 사용하도록 설정

    // getaddrinfo() 함수를 호출하여 도메인 주소 정보를 얻어와 메모리에 저장
    int status = getaddrinfo(domain, NULL, &hints, &addresses);

    struct addrinfo *address = addresses;
    while (address) {
        // ai_addr 멤버가 NULL 인 경우 다음 주소 정보로 이동
        if (address->ai_addr == NULL) {
            address = address->ai_next;
            continue;
        }
        // 현재 주소 정보 체계를 결정
        int family = address->ai_addr->sa_family;
        if (family == AF_INET || family == AF_INET6) {
            // 현재 주소 정보의 주소 체계를 출력
            printf("%s\t", family == AF_INET ? "IPv4" : "IPv6");
            
            // 현재 주소 정보의 IP 주소를 숫자 형태로 출력
            char ap[100];
            const int family_size = family == AF_INET ? sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);
            getnameinfo(address->ai_addr, family_size, ap, sizeof(ap), 0, 0, NI_NUMERICHOST);
            printf("%s\n", ap);
        }
        // 다음 주소 정보로 이동하여 반복
        address = address->ai_next;
    }
    // 메모리 해제
    freeaddrinfo(addresses);
    return 0;
}