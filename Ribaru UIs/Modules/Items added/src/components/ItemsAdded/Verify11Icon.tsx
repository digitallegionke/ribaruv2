import { memo, SVGProps } from 'react';

const Verify11Icon = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 84 84' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M40.1166 4.5593C43.616 3.86859 47.3665 5.1975 49.7273 7.85039C50.8512 8.97094 51.9652 10.0997 53.0923 11.217C53.9782 12.093 55.1939 12.6312 56.4424 12.6591C58.0814 12.6804 59.722 12.6509 61.361 12.6738C63.6825 12.723 65.9679 13.6139 67.7283 15.1266C69.8102 16.8935 71.149 19.5152 71.3114 22.2452C71.3787 24.0696 71.3016 25.8973 71.3524 27.7216C71.4197 28.9095 71.9398 30.0595 72.7781 30.9028C74.0857 32.2219 75.408 33.5245 76.7123 34.8452C78.1364 36.3021 79.1027 38.1937 79.4489 40.2019C79.9444 42.9319 79.2734 45.8538 77.6196 48.0834C77.0273 48.9021 76.2792 49.5846 75.5737 50.2999C74.6452 51.2334 73.7084 52.1587 72.7814 53.0939C71.9398 53.9372 71.4148 55.0905 71.3475 56.2816C71.2868 58.1897 71.3967 60.101 71.2868 62.0074C71.0505 64.8063 69.5756 67.4609 67.3559 69.1753C65.6135 70.5403 63.4184 71.3147 61.2019 71.3327C59.6728 71.3409 58.1421 71.3278 56.6114 71.3377C55.6221 71.3393 54.6328 71.6313 53.8158 72.1924C53.2645 72.5616 52.8199 73.062 52.3491 73.5262C51.2548 74.614 50.1736 75.7165 49.0711 76.796C47.1893 78.6023 44.5955 79.6343 41.9885 79.6195C39.2749 79.6327 36.5876 78.4875 34.6861 76.5565C33.5902 75.4605 32.4942 74.3662 31.3999 73.2703C30.4648 72.2055 29.1637 71.4082 27.7216 71.3491C25.9695 71.3048 24.214 71.3639 22.4618 71.3196C19.9303 71.2212 17.4677 70.1121 15.6795 68.3255C13.8436 66.5011 12.728 63.9647 12.6705 61.3741C12.6476 59.7286 12.6788 58.083 12.6558 56.4359C12.623 55.189 12.0914 53.9684 11.212 53.0857C9.90773 51.7683 8.58539 50.4689 7.28273 49.1498C5.50758 47.3452 4.46578 44.8514 4.39195 42.3232C4.29516 39.5784 5.35336 36.8058 7.28438 34.8469C8.59031 33.5278 9.91266 32.2252 11.2186 30.9061C11.97 30.1448 12.4753 29.1424 12.6148 28.0793C12.8723 25.1327 12.2079 22.0385 13.3596 19.2183C14.7394 15.5925 18.3127 12.9216 22.1944 12.6902C23.9794 12.6279 25.7677 12.6935 27.5543 12.6574C28.8012 12.623 30.0234 12.0963 30.9077 11.217C32.2252 9.91266 33.5278 8.59359 34.8436 7.28765C36.2759 5.87672 38.1445 4.93008 40.1166 4.5593ZM40.7498 9.78305C39.8934 10.0029 39.1027 10.4541 38.4727 11.0742C37.1831 12.3555 35.9084 13.6516 34.6205 14.9346C33.2998 16.252 31.6116 17.1987 29.797 17.6302C27.2918 18.1962 24.7029 17.745 22.1681 17.9714C19.8909 18.2749 18.0091 20.3323 17.9255 22.6308C17.8927 24.2747 17.9271 25.9202 17.9091 27.5658C17.8763 30.1087 16.8525 32.6255 15.0888 34.4613C13.6877 35.8936 12.2391 37.2799 10.8544 38.727C9.2318 40.5152 9.23016 43.4864 10.8478 45.278C12.2325 46.7283 13.6845 48.1146 15.0855 49.5502C16.8082 51.3417 17.8369 53.7862 17.9041 56.2718C17.9386 58.0174 17.8795 59.7647 17.9353 61.5103C18.0846 63.8941 20.1715 65.9515 22.557 66.0762C24.2796 66.1237 26.0055 66.0745 27.7298 66.1008C30.2531 66.168 32.7337 67.223 34.5319 68.9932C35.8559 70.3008 37.1602 71.628 38.4841 72.9373C39.608 74.0512 41.2765 74.5845 42.8384 74.3055C43.8884 74.1366 44.8629 73.605 45.6061 72.8503C46.894 71.5657 48.177 70.2778 49.4665 68.9948C51.2679 67.218 53.7551 66.1713 56.2816 66.1008C57.9748 66.0762 59.6695 66.1188 61.3627 66.0811C63.2789 65.9991 65.0606 64.6964 65.7398 62.9065C66.2435 61.6875 66.0483 60.3487 66.0877 59.0674C66.1221 57.4891 65.958 55.8813 66.3452 54.3326C66.7275 52.5804 67.6069 50.943 68.8291 49.6338C70.204 48.2262 71.6166 46.8546 72.993 45.4486C74.3548 44.0475 74.7534 41.8277 73.9709 40.0395C73.4311 38.7122 72.2302 37.8541 71.2852 36.8353C70.0071 35.4867 68.5092 34.3055 67.5544 32.6862C66.6504 31.1932 66.1401 29.4656 66.0942 27.72C66.0778 26.629 66.0926 25.5363 66.0877 24.4437C66.0729 23.3494 66.1844 22.2141 65.7694 21.1739C65.1115 19.3495 63.3101 18.0059 61.3676 17.9271C59.6728 17.8943 57.978 17.937 56.2833 17.9058C53.7895 17.8434 51.3352 16.818 49.5387 15.0855C48.1655 13.7337 46.8169 12.3555 45.442 11.007C44.2247 9.8257 42.3872 9.35484 40.7498 9.78305Z'
      fill='#159500'
      fillOpacity={0.5}
    />
    <path
      d='M50.5936 33.198C51.5796 32.1727 53.3941 32.217 54.3441 33.267C55.2989 34.2398 55.2759 35.9576 54.3014 36.9091C49.6831 41.5324 45.0581 46.1541 40.4381 50.7757C39.4111 51.9438 37.4243 51.87 36.4547 50.6674C34.189 48.3886 31.9069 46.1262 29.6428 43.8457C28.688 42.8712 28.7339 41.1551 29.7084 40.2117C30.6567 39.2306 32.381 39.188 33.3555 40.151C35.0782 41.854 36.7845 43.5734 38.4989 45.2862C42.5348 41.2601 46.5609 37.2241 50.5936 33.198Z'
      fill='#159500'
    />
  </svg>
);

const Memo = memo(Verify11Icon);
export { Memo as Verify11Icon };